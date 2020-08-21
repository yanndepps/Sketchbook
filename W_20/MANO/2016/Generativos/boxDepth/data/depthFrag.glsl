#version 120

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
 
uniform vec4 nearColor = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 farColor = vec4(0.0, 0.0, 0.0, 1.0);
uniform float near = 0.0;
uniform float far = 100.0;
 
varying vec4 vertColor;
 
void main() {
	gl_FragColor = mix(nearColor, farColor, smoothstep(0.0, far-near, abs(gl_FragCoord.z / gl_FragCoord.w-near)));
}
