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

    float frame = floor(time * 11.0);
    float row = floor(uv.y * resolution.y * 0.075);
    float col_block = floor(uv.x * resolution.x * 0.055);

    float glitch_gate = step(0.76, hash(vec2(frame, row)));
    float glitch_shift = (hash(vec2(row, frame + 7.0)) - 0.5) * 0.032 * glitch_gate;
    uv.x += glitch_shift;

    float tear = step(0.87, hash(vec2(frame * 0.73, row + 3.0)));
    uv.y += (hash(vec2(row, frame * 1.9)) - 0.5) * 0.010 * tear;

    float block_noise = hash(vec2(col_block, floor(uv.y * resolution.y * 0.11) + frame));
    float smear = step(0.68, block_noise) * glitch_gate;
    uv.x += (block_noise - 0.5) * 0.055 * smear;

    float grain = hash(floor(uv * resolution.xy * 0.18) + vec2(frame, frame * 0.31));
    float snow = (grain - 0.5) * 0.18;

    float blotch = noise(uv * vec2(0.95, 1.7) + vec2(0.0, time * 0.016));
    float stain = noise(uv * vec2(0.45, 0.8) + vec2(12.0, 5.0));
    float scars = noise(uv * vec2(8.0, 26.0) + vec2(time * 0.06, 0.0));
    float grit = noise(uv * vec2(20.0, 12.0) + vec2(40.0, frame * 0.02));

    float bars = 0.5 + 0.5 * sin(uv.y * resolution.y * 0.18 + time * 0.15);
    float scanline = 0.90 - 0.10 * sin(uv.y * resolution.y * 0.82);
    float flicker = 0.95 + 0.05 * sin(time * 9.0 + uv.y * 6.0);
    float vignette = smoothstep(1.10, 0.12, length(p));

    float dead_band = step(0.84, hash(vec2(frame * 0.7, row))) * 0.14;
    float bright_band = step(0.90, hash(vec2(frame * 1.3, row + 9.0))) * 0.18;
    float dropout = step(0.93, hash(vec2(frame * 1.1, col_block + row))) * 0.20;

    float crt = 0.03 + 0.32 * blotch + 0.24 * stain + 0.12 * bars;
    crt += (scars - 0.5) * 0.16;
    crt += (grit - 0.5) * 0.08;
    crt += snow;
    crt += bright_band - dead_band - dropout;
    crt *= scanline * flicker;
    crt *= 0.46 + 0.54 * vignette;

    float harsh = smoothstep(0.22, 0.82, crt);
    crt = mix(crt, harsh, 0.42);

    vec3 black = vec3(0.006, 0.006, 0.008);
    vec3 gray = vec3(0.22, 0.22, 0.26);
    vec3 white = vec3(0.84, 0.85, 0.90);

    float level = clamp(crt, 0.0, 1.0);
    vec3 col = mix(black, gray, smoothstep(0.04, 0.36, level));
    col = mix(col, white, smoothstep(0.56, 0.88, level));
    col = clamp((col - 0.08) * 1.42 + 0.08, 0.0, 1.0);

    float alpha = intensity * (0.20 + 0.48 * level) * vignette;
    alpha *= 0.92 + 0.08 * flicker;
    alpha *= 0.92 + 0.08 * glitch_gate;

    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    alpha *= 1.0 - text_pixel;

    FRAG_COLOR = vec4(col, alpha);
}
