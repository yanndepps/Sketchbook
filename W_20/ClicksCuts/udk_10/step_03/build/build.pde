//waveToProcessing.pde
import oscP5.*;
import netP5.*;
OscP5 oscP5;

final int BUFFERSIZE= 735;  //should correspond with bufferSize in supercollider
float[] waveData;

void setup() {
    size(735, 735, FX2D);
    frameRate(60);
    background(0);
    
    waveData= new float[BUFFERSIZE];
    for (int i= 0; i<BUFFERSIZE; i++) {
        waveData[i]= 0.0;
    }
    
    OscProperties properties= new OscProperties();
    properties.setListeningPort(47130);  //osc receive port (from sc)
    properties.setDatagramSize(5136);  //5136 is the minimum 
    oscP5= new OscP5(this, properties);
}
void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/waveData")) {
        for (int i= 0; i<BUFFERSIZE; i++) {
            waveData[i]= msg.get(i).floatValue();
        }
    }
}
void draw() {
    if (frameCount%100==0) {
        println(frameRate);
    }

    noStroke();
    fill(0, 10);  //a bit of trail effect
    rect(0, 0, width, height);
    
    translate(width*0.5, height*0.5);
    scale(map(mouseY, 0, height, 0.95, 1.25));
    rotate(map(mouseX, 0, width, -0.5, 0.5));
    translate(-width*0.5, -height*0.5);
    image(get(), 0, 0);

    stroke(255);
    translate(0, height*0.5);
    float ly= 0;
    for (int x= 1; x<BUFFERSIZE; x++) {
        float y= waveData[x]*255.0;
        //line(x, y, x, 0);
        line(x, y, x-1, ly);
        //rect(x, y, 1, 1);
        ly= y;
    }
}
