// shader example for Processing
// uniform - variables set in Processing sketch using shader.set()
// varying - variables set by Processing itself

// image to process
uniform sampler2D texture;
// mouse position normalized
uniform vec2 inp;

// vertex color
varying vec4 vertColor;
// vertex position
varying vec4 vertTexCoord;

#define TWO_PI (6.28318530718)

void main() {	
  vec4 col = texture2D(texture,vertTexCoord.xy); // take color from texture
  float lumaang =  TWO_PI*(0.2126 * col.r + 0.7152 * col.g + 0.0722 * col.b); // calculate luma 
  vec2 off = vec2(2.0*inp.x*sin(lumaang),2.0*inp.y*cos(lumaang)); // calculate offset vector from luma angle
  gl_FragColor = vec4(texture2D(texture, fract(vertTexCoord.st+off)).rgb,1.0); // set color from texture from current position + offest. Wrapped.
}