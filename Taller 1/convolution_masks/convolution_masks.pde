import java.util.*;

PGraphics pg, pg2;
PImage image1, image2;

float[][] edge1 =   {  {1, 0,-1},
                     {0, 0, 0,},
                     {-1,0, 1}};
float[][] edge2 =   {  {0, 1,0},
                     {1, -4, 1,},
                     {0,1, 0}};
float[][] edge3 =   {  {-1, -1,-1},
                     {-1, 8, -1,},
                     {-1,-1, -1}};
float[][] identity =   {  {0, 0,0},
                     {0, 1, 0,},
                     {0,0, 0}};       
float[][] sharpen =   {  {0, -1,0},
                     {-1,5, -1,},
                     {0,-1, 0}};       
float[][] blur =   {  {0.11, 0.11,0.11},
                     {0.11,0.11, 0.11,},
                     {0.11,0.11, 0.11}};                        
float[][] matrix = blur;

void setup(){
  size(1520,560);
  textSize(20);
  pg = createGraphics(730,500);
  pg2 = createGraphics(730,500);
  image1 = loadImage("melancholia.jpg");
  image1.resize(730,500);  
}

void draw(){
  fill(255,0,0);
  text("blur - 1", 20, 30);  
  
  pg.beginDraw();
  pg.image(image1,0,0);
  pg.endDraw();
  
  pg2.beginDraw();
  pg2.image(image1,0,0);
  pg2.loadPixels();
  for (int y = 1; y < pg2.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < pg2.width-1; x++) {  // Skip left and right edges
      float sum = 0;
      float sum_red=0 ;
      float sum_green=0; 
      float sum_blue=0;
      // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*pg2.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val_red = red(pg2.pixels[pos]);
          float val_green = green(pg2.pixels[pos]);
          float val_blue = blue(pg2.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum_red += matrix[ky+1][kx+1] * val_red/1 ;  
          sum_green += matrix[ky+1][kx+1] * val_green/1 ;  
          sum_blue += matrix[ky+1][kx+1] * val_blue/1 ;  
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      pg2.pixels[y*pg2.width + x] = color(sum_red,sum_green,sum_blue);
    }
  }
  pg2.updatePixels();
  pg2.endDraw();
  
  image(pg,20,40);
  image(pg2,770,40);
}

void keyPressed(){
int keyNum = Character.getNumericValue(key);
if(keyNum<=9 && keyNum>0){
  num = keyNum;
}
} 
