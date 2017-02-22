import processing.sound.*;
import processing.serial.*;

Serial myPort;  
int linefeed = 10;
SoundFile file;
int theValue;

//https://github.com/processing/processing-sound/issues/31

// changes to this. 
// if the value suddenly dips to 0, don't just cut it to the slow speed
	// make the sound start decreasing slowly b X
	// until it receives a 

 void setup() {
	size(640, 360);
	background(255);
	printArray(Serial.list());
  	myPort = new Serial(this, Serial.list()[1],9600);
	myPort.bufferUntil(linefeed);

	// Load a soundfile from the /data folder of the sketch and play it back
	
	file = new SoundFile(this, "heart.aiff");
  	file.loop();
	file.amp(0.025);
}      

void draw() {

	println("theValue: "+theValue);
	file.amp(map(theValue, 0, 10, 0.25, 1.0));
	file.rate(map(theValue,0,30,0.25, 2.2));
}

void serialEvent(Serial myPort){
  String myString = myPort.readStringUntil(linefeed);
  if(myString != null){
    myString = trim(myString);
    int i = int(myString);
    theValue = i;
  }
}