#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float time;

void main() {
    vec2 p = (gl_FragCoord.xy - 100.0) * 0.03;
    float r = 0.5 + 0.5 * sin(p.x * p.y * 1.1 + time);
    float g = 0.5 + 0.5 * sin(p.x * p.y * 1.2 + time);
    float b = 0.5 + 0.5 * sin(p.x * p.y * 1.3 + time);
    gl_FragColor = vec4(r, g, b, 1.0);
}
