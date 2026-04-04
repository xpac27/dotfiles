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

float fbm(vec2 p)
{
    float v = 0.0;
    float a = 0.5;
    mat2 m = mat2(1.6, 1.2, -1.2, 1.6);
    for (int i = 0; i < 5; i++) {
        v += a * noise(p);
        p = m * p;
        a *= 0.55;
    }
    return v;
}

float field(vec2 p)
{
    float t = time * 0.11;

    vec2 q = p;
    q += 0.08 * vec2(sin(t + p.y * 2.7), cos(t * 0.9 - p.x * 2.1));

    float a = fbm(q * 2.0 + vec2(0.12 * t, -0.08 * t));
    float b = fbm((q + vec2(a, -a) * 0.25) * 3.7 + vec2(-0.07 * t, 0.10 * t));
    float c = fbm((q + vec2(b, a) * 0.30) * 6.2 + vec2(0.03 * sin(t * 1.4), 0.05 * cos(t * 1.2)));

    float ribbons = sin((q.x + a * 0.8) * 6.0 + t * 1.1) * sin((q.y - b * 0.6) * 5.0 - t * 0.8);
    float pulse = 0.5 + 0.5 * sin(t * 1.7 + a * 5.0 + b * 3.0);

    float f = a * 0.50 + b * 0.32 + c * 0.18;
    f += ribbons * 0.08;
    f += pulse * 0.06;
    return f;
}

float color_field(vec2 p)
{
    float t = time * 0.07;
    vec2 q = p * 0.85;
    q += vec2(0.10 * sin(t + p.y * 1.3), 0.12 * cos(t * 0.8 - p.x * 1.1));

    float a = fbm(q * 1.4 + vec2(0.05 * t, -0.03 * t));
    float b = fbm((q + vec2(a, -a) * 0.30) * 2.2 + vec2(-0.04 * t, 0.06 * t));

    return clamp(a * 0.58 + b * 0.42, 0.0, 1.0);
}

void main()
{
    vec2 uv = v_tex_coord;
    vec2 p = uv - 0.5;
    p.x *= resolution.x / max(resolution.y, 1.0);
    p *= 1.25;

    float h = field(p);
    float eps = 0.004;
    float hx = field(p + vec2(eps, 0.0)) - h;
    float hy = field(p + vec2(0.0, eps)) - h;
    vec3 normal = normalize(vec3(-hx * 20.0, -hy * 20.0, 1.0));

    vec3 light = normalize(vec3(-0.4, -0.25, 0.88));
    float diffuse = clamp(dot(normal, light), 0.0, 1.0);
    float fresnel = pow(1.0 - max(normal.z, 0.0), 2.8);
    float sheen = pow(clamp(dot(reflect(vec3(0.0, 0.0, -1.0), normal), normalize(vec3(0.35, -0.1, 0.7))), 0.0, 1.0), 6.0);

    float body = smoothstep(0.16, 0.82, h + 0.05);
    float folds = smoothstep(0.38, 0.94, h + diffuse * 0.15);
    float pockets = smoothstep(0.62, 0.08, h);

    float zone = color_field(p + vec2(0.25 * h, -0.18 * h));
    float z_red = 1.0 - smoothstep(0.33, 0.56, zone);
    float z_yellow = smoothstep(0.28, 0.52, zone) * (1.0 - smoothstep(0.58, 0.78, zone));
    float z_white = smoothstep(0.64, 0.84, zone);

    vec3 black = vec3(0.04, 0.04, 0.04);
    vec3 gray = vec3(0.46, 0.46, 0.46);
    vec3 white = vec3(0.96, 0.96, 0.96);

    vec3 palette = black * z_red + gray * z_yellow + white * z_white;
    float palette_weight = max(z_red, max(z_yellow, z_white));
    palette = mix(black, palette, clamp(palette_weight, 0.0, 1.0));

    float shading = 0.42 + 0.38 * body + 0.28 * folds + 0.18 * diffuse;
    vec3 col = palette * shading;
    col = mix(col, white, sheen * 0.10 + fresnel * 0.05);
    col *= 0.86 + 0.20 * pockets;

    float vignette = smoothstep(1.18, 0.22, length(p));
    float alpha_wave = 0.88 + 0.12 * sin(time * 0.32 + h * 2.2);
    float alpha = intensity * (0.10 + 0.12 * body + 0.10 * folds + 0.08 * sheen) * vignette * alpha_wave;

    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    alpha *= 1.0 - text_pixel;

    FRAG_COLOR = vec4(col, alpha);
}
