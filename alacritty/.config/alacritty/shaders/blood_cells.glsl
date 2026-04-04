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

vec2 random2(vec2 p)
{
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float sm_vr(vec2 st)
{
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float c = 0.0;
    for (int j = -1; j <= 1; j++) {
        for (int i = -1; i <= 1; i++) {
            vec2 neighbor = vec2(float(i), float(j));
            vec2 point = random2(i_st + neighbor);
            point = 0.5 + 0.5 * sin(time + 6.2831 * point);
            vec2 diff = neighbor + point - f_st;
            float wobble = sin(time * length(random2(i_st + neighbor))) * 0.25 + 0.25;
            float dist = length(diff) + wobble;
            c += exp(-16.0 * dist);
        }
    }

    return -(1.0 / 16.0) * log(c);
}

void main()
{
    vec2 st = v_tex_coord;
    st.x *= resolution.x / max(resolution.y, 1.0);

    vec3 base = vec3(0.135, 0.077, 0.095);
    st *= 5.0;

    float c = 0.0;
    for (int layer = 3; layer >= 0; layer--) {
        float fi = float(layer);
        float scale = exp2(fi);
        float vr = sm_vr(st * scale + vec2(sin(time) + time, 0.0));
        vr = smoothstep(0.0, 1.5, vr * (sin(time + fi) + 4.25) * 0.25);
        c = mix(c, vr, 1.0 - smoothstep(0.4, 0.5, vr));
        c = (c + 0.325) * (1.0 - fi * 0.25);
    }

    vec3 blood = vec3(0.425, 0.110, 0.103) * c;
    vec3 col = mix(base, blood, clamp(c * 1.35, 0.0, 1.0));

    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    float alpha = intensity * clamp(0.18 + c * 0.42, 0.0, 1.0) * (1.0 - text_pixel);

    FRAG_COLOR = vec4(col, alpha);
}
