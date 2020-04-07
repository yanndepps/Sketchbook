uniform vec3 iResolution; 
uniform float iGlobalTime;
uniform vec4 iMouse;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
    // center of the screen
    uv -= .5;
    // aspect ratio of the screen
    uv.x *= iResolution.x / iResolution.y;
    float d = length(uv);
    // radius
    float r = 0.3;
    // smooth circle
    float c = smoothstep(r, r-0.01, d);
    
	//if(d < .3) c = 1.; else c = 0.;
    
    // Output to screen
    fragColor = vec4(vec3(c), 1.0);
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}
