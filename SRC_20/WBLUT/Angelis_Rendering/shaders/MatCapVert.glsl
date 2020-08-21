#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

attribute vec4 vertex;
attribute vec3 normal;
varying vec3 N;

void main() {    
  N = normalize(normalMatrix * normal); 
  gl_Position = transform * vertex;
}

