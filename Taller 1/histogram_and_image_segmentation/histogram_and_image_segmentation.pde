PImage image1, image2;
PGraphics pg1, pg2;
int[] hist = new int[256];
// Find the largest value in the histogram
int histMax=0;

void setup(){
size(1660, 450);
//image1 = loadImage("landscape.png");
//image2 = loadImage("landscape.png");
//image1 = loadImage("TheHouseThatJackBuilt.jpg");
//image2 = loadImage("TheHouseThatJackBuilt.jpg");
//image1 = loadImage("fluorescence.jpg");
//image2 = loadImage("fluorescence.jpg");
image1 = loadImage("joker.jpg");
image2 = loadImage("joker.jpg");
image1.resize(800,410);
image2.resize(800,410);
for (int i = 0; i < image1.pixels.length; i++) {  
    int bright = int(brightness(image1.pixels[i]));
    hist[bright]++;  
}
for (int i = 0; i < image1.pixels.length; i++) {  
    if(hist[int(brightness(image1.pixels[i]))]>18000){
      image2.pixels[i]=color(255);
    }else{
      image2.pixels[i]=color(0);
    }
    /*if(int(brightness(image1.pixels[i]))<20){
      image2.pixels[i]=color(255);
    }*/
}
histMax = max(hist);
int mapMaxHist = int(map(histMax, 0 , histMax , 0,image1.height));
print("MAXIMOOO:",mapMaxHist);
pg1 = createGraphics(800,410);
pg2 = createGraphics(800,410);
}

void draw(){
  pg1.beginDraw();
  pg1.image(image1,0,0);
  
// Find the largest value in the histogram
  pg1.endDraw();
  image(pg1, 20, 20);
  
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
  line(i+20, pg2.height+20, i+20, y+20);
}
  for (int i = 0; i < pg2.pixels.length; i++) {  
    pg2.pixels[i]= image2.pixels[i];
}
  pg2.updatePixels();
  pg2.endDraw();
  image(pg2,840,20);

}
