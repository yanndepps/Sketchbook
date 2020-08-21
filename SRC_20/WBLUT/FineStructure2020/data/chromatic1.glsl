// Isotropic chromatic shader
// Adapted by Frederik Vanhoutte
//
// Based on
// https://www.shadertoy.com/view/XssGz8 by hornet
// Processing Port by Raphaël de Courville <twitter: @sableRaph>

#ifdef GL_ES
precision highp float;
#endif


#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution=vec2(1920.0,1080.0);

uniform float lens=1.0;
uniform int levels = 48;
uniform float gamma = 4.2;
uniform float rangestart = 0.15;
uniform float rangeend = 0.85;
uniform float invert=0.0;
uniform vec3 lowcolor=vec3(1.,0.,0.);
uniform vec3 midcolor=vec3(0.,1.,0.);
uniform vec3 highcolor=vec3(0.,0.,1.);

float triangle( float t, float a, float b ) {
    float map=clamp( (t - a) / (b - a),0.0,1.0 );
    return clamp( 1.0 - abs( 2.0*map - 1.0 ) ,0.0,1.0);
}


vec3 colorshift( float t, float rs, float re) {
    vec3 ret;
    float tt=(invert>0)?1.0-t:t;
    float low = step(tt,0.5);
    float w = triangle( tt, rs, re );
    float lcf=low*(1.0-w);
    float hcf=(1.0-low)*(1.0-w);

  ret = lcf*lowcolor+w*midcolor+hcf*highcolor;
    return pow( ret, vec3(1.0/gamma) );
}


vec2 lensing(vec2 p, float strength) {
    vec2 centered = p - 0.5;
    return p  + strength * dot(centered, centered) * centered;
}


void main()
{   
   vec2 uv=gl_FragCoord.xy/resolution.xy;
    
    vec3 colorbin = vec3(0.0);
    vec3 weightbin = vec3(0.0);  
    for ( int i=0; i<levels+1;++i )
    {
        float t = float(i)/ levels;
        vec3 weight = colorshift( t ,rangestart,rangeend);
        weightbin += weight;
        colorbin += weight * texture2D( texture, lensing(uv, lens*t ) ).rgb;//lens*(2.0*uv.x-1.0)*t
    }
        
    gl_FragColor = vec4(colorbin.rgb / weightbin, 1.0);
}