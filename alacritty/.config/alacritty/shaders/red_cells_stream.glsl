#ifdef GLES2_RENDERER
precision mediump float;
varying vec2 v_tex_coord;
#define FRAG_COLOR gl_FragColor
#define TEXTURE texture2D
#else
in vec2 v_tex_coord;
out vec4 color;
#define FRAG_COLOR color
#define TEXTURE texture
#endif

uniform float time;
uniform float intensity;
uniform vec2 resolution;
uniform sampler2D text_mask;

float hash(vec2 p)
{
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

mat2 rot(float a)
{
    float c = cos(a);
    float s = sin(a);
    return mat2(c, -s, s, c);
}

float plasma_noise(vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

vec3 blood_particle(vec2 centered_uv, float layer_seed, float layer_speed, float spread, float count)
{
    float t = time * layer_speed;
    float best_dist = 10.0;
    float best_depth = 0.0;
    float best_variant = 0.0;

    for (int i = 0; i < 28; i++) {
        float fi = float(i);
        float id = fi + layer_seed * 53.0;

        float cycle = fract(hash(vec2(id, layer_seed + 1.7)) + t * (0.06 + count * 0.008));
        float depth = 0.16 + pow(cycle, 1.9) * spread;

        float angle = hash(vec2(id, layer_seed + 4.1)) * 6.2831853;
        float curve = 0.28 * sin(t * 0.55 + fi * 1.27);
        vec2 dir = vec2(cos(angle + curve), sin(angle - curve * 0.7));

        float radial = depth * (0.18 + 0.85 * cycle);
        vec2 center = dir * radial;
        center += vec2(
            0.035 * sin(t * 0.45 + fi * 2.31),
            0.045 * cos(t * 0.38 + fi * 1.87)
        ) * (0.35 + cycle);

        vec2 delta = centered_uv - center;
        float twist = hash(vec2(id, layer_seed + 12.4)) * 6.2831853;
        delta = rot(twist) * delta;

        float squash_x = mix(0.78, 1.55, hash(vec2(id, layer_seed + 2.0)));
        float squash_y = mix(0.82, 1.7, hash(vec2(id, layer_seed + 3.0)));
        delta.x *= squash_x / (0.72 + depth * 0.55);
        delta.y *= squash_y / (0.72 + depth * 0.55);

        float ripple = 1.0 + 0.12 * sin(atan(delta.y, delta.x) * 2.0 + fi * 1.13);
        float dist = length(delta) * ripple;

        if (dist < best_dist) {
            best_dist = dist;
            best_depth = depth;
            best_variant = hash(vec2(id, layer_seed + 15.0));
        }
    }

    float radius = mix(0.045, 0.10, best_depth);
    float body = smoothstep(radius * 2.2, radius * 0.78, best_dist);
    float core = smoothstep(radius * 1.05, radius * 0.22, best_dist);
    float rim = smoothstep(radius * 1.7, radius * 0.95, best_dist)
        - smoothstep(radius * 0.88, radius * 0.42, best_dist);
    float dent = smoothstep(radius * 0.52, radius * 0.16, best_dist);

    float volume = rim * mix(0.35, 0.75, best_variant);
    volume += core * mix(0.04, 0.16, 1.0 - best_variant);
    volume -= dent * mix(0.05, 0.16, best_variant);

    return vec3(body, clamp(volume, 0.0, 1.0), best_depth);
}

void main()
{
    vec2 uv = v_tex_coord;
    vec2 centered = uv - 0.5;
    centered.x *= resolution.x / max(resolution.y, 1.0);

    float t = time * 0.10;
    vec2 drift = vec2(
        0.018 * sin(t * 0.7 + centered.y * 6.0),
        0.026 * cos(t * 0.55 + centered.x * 5.5)
    );
    vec2 stream_uv = centered + drift;

    vec3 far_cells = blood_particle(stream_uv, 1.7, 0.24, 0.75, 1.0);
    vec3 mid_cells = blood_particle(stream_uv, 4.9, 0.31, 0.98, 1.25);
    vec3 near_cells = blood_particle(stream_uv, 8.3, 0.39, 1.18, 1.55);

    float presence = far_cells.x * 0.45 + mid_cells.x * 0.78 + near_cells.x * 0.96;
    presence = clamp(presence, 0.0, 1.0);

    float volume = far_cells.y * 0.22 + mid_cells.y * 0.58 + near_cells.y * 0.92;
    volume = clamp(volume, 0.0, 1.0);

    float depth = far_cells.z * 0.2 + mid_cells.z * 0.34 + near_cells.z * 0.46;

    float plasma_a = plasma_noise(uv * 4.0 + vec2(t * 0.35, -t * 0.2));
    float plasma_b = plasma_noise(uv * 7.5 + vec2(-t * 0.25, t * 0.3));
    float plasma_c = plasma_noise(stream_uv * 9.0 + vec2(3.1, -2.4));
    float plasma = plasma_a * 0.45 + plasma_b * 0.35 + plasma_c * 0.20;
    plasma = smoothstep(0.18, 0.88, plasma);

    float vignette = smoothstep(1.45, 0.08, length(centered));

    vec3 deep_blood = vec3(0.07, 0.0, 0.0);
    vec3 plasma_blood = vec3(0.18, 0.01, 0.02);
    vec3 blood = vec3(0.34, 0.02, 0.03);
    vec3 warm_blood = vec3(0.46, 0.05, 0.05);
    vec3 highlight = vec3(0.60, 0.10, 0.09);

    vec3 color_mix = mix(deep_blood, plasma_blood, 0.45 + 0.55 * plasma);
    color_mix = mix(color_mix, blood, presence * 0.7);
    color_mix = mix(color_mix, warm_blood, volume * (0.15 + 0.45 * plasma));
    color_mix = mix(color_mix, highlight, volume * volume * (0.10 + 0.45 * depth));

    float haze = 0.11 + 0.16 * plasma + 0.05 * depth;
    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    float alpha = intensity * (haze + 0.08 * presence + 0.08 * volume) * vignette;
    alpha *= 1.0 - text_pixel;

    FRAG_COLOR = vec4(color_mix, alpha);
}
