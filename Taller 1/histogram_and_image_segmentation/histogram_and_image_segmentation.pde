import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.*;

PImage image1, image2;
PGraphics pg1, pg2;
int[] hist = new int[256];
color c1 = #00001a;
color c2 = #a64dff;
color c3 = #ff1a1a;
color c4 = #47d147;

color[] colors  = {  
  c1, c2, c3, c4
};

String images ="Star Wars-1      The House That Jack Built-2      Fluorescence-3      Joker-4      Tree of Life-5      Antichrist-6";

// Find the largest value in the histogram
int histMax=0, mapMeanHist=0;

void setup(){
  size(1660, 480);
  textSize(20);
  image1 =  loadImage("star-wars.jpg");  image1.resize(800,410);
  pg1 = createGraphics(800,410);
  pg2 = createGraphics(800,410);
  
  for (int i = 0; i < image1.pixels.length; i++) {  
      int bright = int(brightness(image1.pixels[i]));
      hist[bright]++;  
  }
  int histValues =0;
  for (int i = 0; i < hist.length; i++) {  
      histValues+=hist[i];
  }
  histMax = max(hist);
  int meanHist = histValues/256;
  mapMeanHist = int(map(meanHist, 0 , histMax , 0,image1.height));
  fill(0);
  text(images, 340, 40);   
}

void draw(){
  pg1.beginDraw();
  pg1.image(image1,0,0);
  pg1.endDraw();   
  image(pg1, 20, 60);
  
  pg2.beginDraw();
  pg2.loadPixels();
  pg2.image(image1,0,0);
  stroke(255);
// Draw half of the histogram (skip every second value)
for (int i = 0; i < pg2.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, pg2.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist[which], 0, histMax, pg2.height, 0));
  line(i+20, pg2.height+60, i+20, y+60);
}
for (int i = 0; i < image1.pixels.length; i++) { 
     int position = int(brightness(image1.pixels[i]));
     if(position>=0 && position <64){
       pg2.pixels[i] = colors[0];
     }else if(position >=64 && position <128){
       pg2.pixels[i] = colors[1];
     }else if(position >=128 && position <192){
       pg2.pixels[i] = colors[2];
     }else if(position >=192 && position <256){
       pg2.pixels[i] = colors[3];
     }
  
    /*if(hist[int(brightness(image1.pixels[i]))]< mapMeanHist){
      image2.pixels[i]=color(0);
    }else{
      image2.pixels[i]=image1.pixels[i];
    }*/
    /*if(int(brightness(image1.pixels[i]))<20){
      image2.pixels[i]=color(255);
    }*/
}
  pg2.updatePixels();
  pg2.endDraw();
  image(pg2,840,60);

}

void keyPressed(){
int keyNum = Character.getNumericValue(key);
pg1.clear();
pg2.clear();
if(keyNum<=9 && keyNum>0){
  switch(keyNum){
    case 1:
      image1 =  loadImage("star-wars.jpg");
      break;
    case 2: 
      image1 = loadImage("TheHouseThatJackBuilt.jpg");
      break;
    case 3:
      image1 = loadImage("fluorescence.jpg");
      break;
    case 4: 
      image1 = loadImage("joker.jpg");
      break;
    case 5:
      image1 = loadImage("tree-of-life.jpg");
      break;
    case 6:
      image1 = loadImage("antichrist.jpg");
      break;
    }
  }
  image1.resize(800,410);
}
/*pg2.clear();
  if(key=='+'){
    mapMeanHist+=100; 
  }else if(key=='-'){
    mapMeanHist-=100;
  }*/

  
