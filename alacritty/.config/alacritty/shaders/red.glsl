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

void main()
{
    float pulse = 0.55 + 0.45 * sin(time * 1.7);
    float sweep = 0.25 + 0.75 * v_tex_coord.y;
    vec3 glow = vec3(1.0, 0.1 + 0.2 * sweep, 0.1);
    float mask = TEXTURE(text_mask, v_tex_coord).r;
    float text_pixel = step(0.05, mask);
    float alpha = (1.0 - text_pixel) * intensity * 0.18 * pulse;
    FRAG_COLOR = vec4(glow, alpha);
}
