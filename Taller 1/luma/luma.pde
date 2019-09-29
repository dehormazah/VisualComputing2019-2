PGraphics pg, pg2;
PImage image1, image2;

void setup(){
  size(1660,540);
  pg = createGraphics(800,500);
  pg2 = createGraphics(800,500);
  image1 = loadImage("the-neon-demon.jpg");
  image1 = loadImage("the-dark-knight.jpg");
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
    float sp_luma1  = (0.8126 * red) + (0.9952 *green) + (0.9992 * blue);
    float luma1 = (0.3126 * red) + (0.7152 *green) + (0.9722 * blue);
    float luma2 = (0.4126 * red) + (0.3152 *green) + (0.9722 * blue);
    float luma3 = (0.01126 * red) + (0.7152 *green) + (0.6722 * blue);
    

    pg2.pixels[i] = color(sp_luma1);
   
  }
  pg2.updatePixels();
  pg2.endDraw();
  
  image(pg,20,20);
  image(pg2,840,20);
}
