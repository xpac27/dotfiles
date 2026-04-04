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
    p = fract(p * vec2(127.1, 311.7));
    p += dot(p, p + 34.23);
    return fract(p.x * p.y);
}

float noise(vec2 p)
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

void main()
{
    vec2 uv = v_tex_coord;
    vec2 p = uv - 0.5;
    p.x *= resolution.x / max(resolution.y, 1.0);

    float frame = floor(time * 10.0);
    float row = floor(uv.y * resolution.y * 0.09);
    float glitch_gate = step(0.82, hash(vec2(frame, row)));
    float glitch_shift = (hash(vec2(row, frame + 7.0)) - 0.5) * 0.022 * glitch_gate;
    uv.x += glitch_shift;

    float chunk_y = floor(uv.y * resolution.y * 0.12);
    float block_noise = hash(vec2(floor(uv.x * resolution.x * 0.08), chunk_y + frame));
    float smear = step(0.76, block_noise) * glitch_gate;
    uv.x += (block_noise - 0.5) * 0.03 * smear;

    float grain = hash(floor(uv * resolution.xy * 0.22) + vec2(frame, frame * 0.31));
    float snow = (grain - 0.5) * 0.14;

    float blotch = noise(uv * vec2(1.1, 2.0) + vec2(0.0, time * 0.018));
    float stain = noise(uv * vec2(0.6, 1.0) + vec2(12.0, 5.0));
    float scars = noise(uv * vec2(6.0, 18.0) + vec2(time * 0.04, 0.0));

    float bars = 0.5 + 0.5 * sin(uv.y * resolution.y * 0.22 + time * 0.14);
    float scanline = 0.92 - 0.08 * sin(uv.y * resolution.y * 0.95);
    float flicker = 0.96 + 0.04 * sin(time * 8.0 + uv.y * 5.0);
    float vignette = smoothstep(1.08, 0.16, length(p));

    float dead_band = step(0.91, hash(vec2(frame * 0.7, chunk_y))) * 0.10;
    float bright_band = step(0.94, hash(vec2(frame * 1.3, chunk_y + 9.0))) * 0.12;

    float crt = 0.06 + 0.28 * blotch + 0.22 * stain + 0.12 * bars;
    crt += (scars - 0.5) * 0.10;
    crt += snow;
    crt += bright_band - dead_band;
    crt *= scanline * flicker;
    crt *= 0.50 + 0.50 * vignette;

    vec3 black = vec3(0.010, 0.011, 0.013);
    vec3 gray = vec3(0.20, 0.21, 0.24);
    vec3 white = vec3(0.80, 0.82, 0.86);

    float level = clamp(crt, 0.0, 1.0);
    vec3 col = mix(black, gray, smoothstep(0.05, 0.42, level));
    col = mix(col, white, smoothstep(0.58, 0.92, level));
    col = clamp((col - 0.10) * 1.28 + 0.10, 0.0, 1.0);

    float alpha = intensity * (0.18 + 0.42 * level) * vignette;
    alpha *= 0.94 + 0.06 * flicker;

    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    alpha *= 1.0 - text_pixel;

    FRAG_COLOR = vec4(col, alpha);
}
