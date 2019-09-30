import processing.video.*;
PGraphics pg1,pg2;
Movie myMovie, myMovie2;
boolean overNormal=false, overBlur=false, overGrayScale=false, overLuma=false, overSharpen=false, overEdge1=false, overEdge2=false, overEdge3=false;
String mask;
int normal_button_x, normal_button_y, blur_button_x, blur_button_y, gray_scale_button_x, gray_scale_button_y,
luma_button_x, luma_button_y, sharpen_button_x, sharpen_button_y, edge1_button_x, edge1_button_y, edge2_button_x, edge2_button_y,
edge3_button_x, edge3_button_y;
int button_width = 150, button_height = 50;

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

void setup() {
  textSize(20);
  size(1540, 640);
  myMovie = new Movie(this,"La-la-land.mp4");
  myMovie2 = new Movie(this,"La-la-land.mp4");
  pg1 = createGraphics(720,486);
  pg2 = createGraphics(720,486);
  myMovie.loop();
  myMovie2.loop();
  normal_button_x = 60;
  normal_button_y = 30;
  gray_scale_button_x= 240;
  gray_scale_button_y=30;
  luma_button_x=420;
  luma_button_y=30;
  blur_button_x=600;
  blur_button_y=30;
  sharpen_button_x=780;
  sharpen_button_y=30;
  edge1_button_x=960;
  edge1_button_y=30;
  edge2_button_x=1140;
  edge2_button_y=30;
  edge3_button_x=1320;
  edge3_button_y=30;  
  
  mask = "identit";
  
  fill(#8c8c8c);
  stroke(#8c8c8c);
  rect(normal_button_x, normal_button_y,button_width , button_height);
  rect(blur_button_x,blur_button_y,button_width , button_height);

}

void draw() {
  update(mouseX, mouseY);
  drawButtons();
  
  pg1.beginDraw();
  pg1.image(myMovie,0,0);  
  pg1.endDraw();
  
  pg2.beginDraw();
  pg2.image(myMovie2,0,0);
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
      if(mask=="normal"){
        pg2.pixels[y*pg2.width + x] = color(sum_red,sum_green,sum_blue);
      }else if(mask=="grayScale"){
        pg2.pixels[y*pg2.width + x] = color(int(sum_red+sum_green+sum_blue)/3);
      }else if(mask=="luma"){
        pg2.pixels[y*pg2.width + x] = color((0.8126 * sum_red) + (0.9952 *sum_green) + (0.9992 * sum_blue));
      }
  }
  pg2.updatePixels();
  pg2.endDraw();
  image(pg1,40,120);
  image(pg2,780,120);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void update(int x, int y) {
  if(overButton(normal_button_x,normal_button_y,button_width,button_height)){
    overNormal = true;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(blur_button_x,blur_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = true;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(sharpen_button_x,sharpen_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = true;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(gray_scale_button_x,gray_scale_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = true;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(luma_button_x,luma_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = true;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(edge1_button_x,edge1_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = true;
    overEdge2 = false;
    overEdge3 = false;    
  }else if(overButton(edge2_button_x,edge2_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = true;
    overEdge3 = false;    
  }else if(overButton(edge3_button_x,edge3_button_y,button_width,button_height)){
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = true;    
  }else{
    overNormal = false;
    overBlur = false;
    overSharpen = false;
    overGrayScale = false;
    overLuma = false;
    overEdge1 = false;
    overEdge2 = false;
    overEdge3 = false;    
  }
}

void drawButtons(){
 if (overNormal) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(normal_button_x, normal_button_y,button_width , button_height);
  fill(0);
  text("normal",normal_button_x+20, normal_button_y+30);
  if (overBlur) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(blur_button_x, blur_button_y,button_width , button_height);
  fill(0);
  text("blur",blur_button_x+20, blur_button_y+30);
  if (overSharpen) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(sharpen_button_x, sharpen_button_y,button_width , button_height);
  fill(0);
  text("sharpen",sharpen_button_x+20, sharpen_button_y+30);
  if (overGrayScale) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(gray_scale_button_x, gray_scale_button_y,button_width , button_height);
  fill(0);
  text("gray scale",gray_scale_button_x+20, gray_scale_button_y+30);
  if (overLuma) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(luma_button_x, luma_button_y,button_width , button_height);
  fill(0);
  text("luma",luma_button_x+20, luma_button_y+30);
  if (overEdge1) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(edge1_button_x, edge1_button_y,button_width , button_height);
  fill(0);
  text("edge1",edge1_button_x+20, edge1_button_y+30);
  if (overEdge2) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(edge2_button_x, edge2_button_y,button_width , button_height);
  fill(0);
  text("edge2",edge2_button_x+20, edge2_button_y+30);
  if (overEdge3) {
    fill(255);
    stroke(255);
  }else{
    fill(#8c8c8c);
    stroke(#8c8c8c);
  }  
  rect(edge3_button_x, edge3_button_y,button_width , button_height);
  fill(0);
  text("edge3",edge3_button_x+20, edge3_button_y+30);  
}

void mousePressed() {
  if (overBlur) {
    matrix = blur;
  }else if(overNormal){
    mask= "normal";
    matrix = identity; 
  }else if(overSharpen){
    matrix =sharpen; 
  }else if(overEdge1){
    matrix = edge1; 
  }else if(overEdge2){
    matrix = edge2; 
  }else if(overEdge3){
    matrix = edge3; 
  }else if(overGrayScale){
    mask = "grayScale"; 
  }else if(overLuma){
    mask= "luma"; 
  }
}

boolean overButton(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}