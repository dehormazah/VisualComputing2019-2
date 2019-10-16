PGraphics pg, pg2;
PImage image1, image2;

String masks ="normal-1      blur-2      sharpen-3      edge1-4      edge2-5      edge3-6";

//kernels para aplicar las máscaras de convolución
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
float[][] matrix = identity;

void setup(){
  size(1520,560);
  textSize(20);
  pg = createGraphics(730,500);
  pg2 = createGraphics(730,500);
  image1 = loadImage("melancholia.jpg");
  image1.resize(730,500);  
  fill(0);
  text(masks, 400, 25);  
}

void draw(){ 
  pg.beginDraw();
  pg.image(image1,0,0);
  pg.endDraw();
  
  pg2.beginDraw();
  pg2.image(image1,0,0);
  pg2.loadPixels();
  // Código para aplicar las máscaras de convolución, adaptado de: https://processing.org/examples/blur.html
  for (int y = 1; y < pg2.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < pg2.width-1; x++) {  // Skip left and right edges
      float sum_red=0 ;
      float sum_green=0; 
      float sum_blue=0;
      // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*image1.width + (x + kx);          
          float val_red = red(image1.pixels[pos]);
          float val_green = green(image1.pixels[pos]);
          float val_blue = blue(image1.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum_red += matrix[ky+1][kx+1] * val_red;  
          sum_green += matrix[ky+1][kx+1] * val_green;  
          sum_blue += matrix[ky+1][kx+1] * val_blue;  
        }
      }
      //Asignar nuevo valor al pixel a partir de la convolución
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
pg2.clear();
if(keyNum<=9 && keyNum>0){
  switch(keyNum){
    case 1:
      matrix =  identity;
      break;
    case 2: 
      matrix = blur;
      break;
    case 3:
      matrix = sharpen;
      break;
    case 4: 
      matrix = edge1;
      break;
    case 5:
      matrix = edge2;
      break;
    case 6:
      matrix = edge3;
      break;
  }
}
} 
