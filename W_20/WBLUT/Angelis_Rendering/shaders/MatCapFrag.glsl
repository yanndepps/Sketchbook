precision mediump float;

uniform sampler2D mctexture;
varying vec3 N;
 vec3 vEye=vec3(0.0,0.0,-1.0);

vec2 matcap(vec3 eye, vec3 normal) {
  vec3 reflected = reflect(eye, normal);
  float m = 2.8284271247461903* sqrt( reflected.z+1.0 );
  return reflected.xy / m + 0.5;
}

void main() {
  vec2 uv = matcap(vEye, N).xy;

  gl_FragColor = vec4(
    texture2D(mctexture, uv).rgb,
    1.0
  );
}
