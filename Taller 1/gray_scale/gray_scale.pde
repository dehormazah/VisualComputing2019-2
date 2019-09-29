PGraphics pg, pg2;
PImage image1, image2;

void setup(){
  size(1420,540);
  pg = createGraphics(680,500);
  pg2 = createGraphics(680,500);
  image1 = loadImage("melancholia.jpg");
  image1.resize(800,500);
}

void draw(){
  
  pg.beginDraw();
  pg.image(image1,0,0);
  pg.endDraw();
  
  pg2.beginDraw();
  pg2.image(image1,0,0);
  pg2.loadPixels();
  for (int i = 0; i < pg2.pixels.length; i++) {
   
    float red = red(pg2.pixels[i]);    
    float green = green(pg2.pixels[i]);
    float blue = blue(pg2.pixels[i]);
    pg2.pixels[i] = color(int((red+green+blue)/3));
   
  }
  pg2.updatePixels();
  pg2.endDraw();
  
  image(pg,20,20);
  image(pg2,720,20);
}
