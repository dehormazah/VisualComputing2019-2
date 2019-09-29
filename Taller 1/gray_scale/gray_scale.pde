PGraphics pg, pg2;
PImage image1, image2;
String type = "grayscale";
String[] images = {"melancholia.jpg","the-neon-demon.jpg","the-dark-knight.jpg"};
int image_index=0;
String options ="Gray Scale-1      Luma-2         <- Previous Image      Next Image ->";

void setup(){
  size(1420,560);
  textSize(20);
  pg = createGraphics(680,500);
  pg2 = createGraphics(680,500);
  image1 = loadImage("melancholia.jpg");
  image1.resize(800,500);
  fill(0);
  text(options, 400, 25);  
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
    if(type=="grayscale"){
      pg2.pixels[i] = color(int((red+green+blue)/3));
    }else if(type=="luma"){
    pg2.pixels[i] = color((0.8126 * red) + (0.9952 *green) + (0.9992 * blue));
    }
   
  }
  pg2.updatePixels();
  pg2.endDraw();
  
  image(pg,20,40);
  image(pg2,720,40);
}

void keyPressed(){
pg2.clear();
 if (key == CODED) {
    if (keyCode == LEFT) {
      image_index-=1;
      if(image_index<0){
        image_index = images.length-1;
      }
      image1 = loadImage(images[image_index]);
    }else if(keyCode == RIGHT){
      image_index+=1;
      if(image_index==images.length){
        image_index = 0;
      }
    }
    image1 = loadImage(images[image_index]);
    image1.resize(800,500);
 }else{
  if(key=='1'){
      type =  "grayscale";
  }else if(key=='2'){
      type =  "luma";
  }
 }
} 
