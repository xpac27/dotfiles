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

float blood_cell_layer(vec2 uv, float layer_scale, float speed, float seed)
{
    vec2 grid_uv = uv * layer_scale;
    vec2 cell = floor(grid_uv);
    vec2 local = fract(grid_uv) - 0.5;

    float nearest = 10.0;

    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 offset = vec2(float(x), float(y));
            vec2 id = cell + offset;
            float rnd = hash(id + seed);
            float rnd2 = hash(id + seed + 17.0);
            float rnd3 = hash(id + seed + 43.0);

            vec2 drift = vec2(
                (rnd - 0.5) * 0.55,
                fract(rnd2 + time * speed + rnd * 0.7) - 0.5
            );

            vec2 center = offset + drift;
            vec2 delta = local - center;
            delta.x *= mix(1.0, 1.8, rnd3);
            delta.y *= mix(1.7, 1.0, rnd);

            float dist = length(delta);
            nearest = min(nearest, dist);
        }
    }

    float body = smoothstep(0.34, 0.08, nearest);
    float rim = smoothstep(0.22, 0.02, abs(nearest - 0.18));
    return clamp(body + rim * 0.35, 0.0, 1.0);
}

void main()
{
    vec2 uv = v_tex_coord;
    vec2 centered = uv - 0.5;
    centered.x *= resolution.x / max(resolution.y, 1.0);

    float t = time * 0.12;
    vec2 flow = vec2(0.03 * sin(t * 0.8), -t * 0.35);
    vec2 swirl = vec2(
        0.02 * sin((uv.y + t) * 8.0),
        0.015 * sin((uv.x - t * 0.7) * 10.0)
    );
    vec2 stream_uv = centered + flow + swirl;

    float far_cells = blood_cell_layer(stream_uv + vec2(0.11, 0.0), 7.0, 0.18, 3.1);
    float mid_cells = blood_cell_layer(stream_uv * 1.35 + vec2(-0.07, 0.13), 10.0, 0.26, 9.7);
    float near_cells = blood_cell_layer(stream_uv * 1.8 + vec2(0.19, -0.09), 14.0, 0.36, 21.4);

    float stream = far_cells * 0.4 + mid_cells * 0.8 + near_cells * 1.15;
    stream = clamp(stream, 0.0, 1.0);

    float haze = 0.5 + 0.5 * sin((uv.y + t * 0.9) * 9.0 + sin(uv.x * 7.0));
    float vignette = smoothstep(1.2, 0.15, length(centered));

    vec3 deep_blood = vec3(0.12, 0.0, 0.0);
    vec3 blood = vec3(0.42, 0.02, 0.03);
    vec3 highlight = vec3(0.58, 0.08, 0.07);

    vec3 color_mix = mix(deep_blood, blood, stream);
    color_mix = mix(color_mix, highlight, stream * stream * (0.35 + 0.65 * haze));

    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    float alpha = intensity * (0.08 + 0.22 * stream) * vignette;
    alpha *= 1.0 - text_pixel;

    FRAG_COLOR = vec4(color_mix, alpha);
}
