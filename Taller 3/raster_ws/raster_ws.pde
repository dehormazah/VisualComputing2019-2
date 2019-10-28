import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;

// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 2;
int DIVISIONS = 5;

int[]red = {255,0,0};
int[]green = {0,255,0};
int[]blue = {0,0,255};


// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 10;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  push();
  float area = edgeFunction(v1, v2, v3); 
  for (float i = -60; i < 60; i+=0.3) { 
        for (float  j = -60; j < 60; j+=0.3) { 
            Vector point  = new Vector(i,j);
            float w0 = edgeFunction(v2, v3, point); 
            float w1 = edgeFunction(v3, v1, point); 
            float w2 = edgeFunction(v1, v2, point); 
          if(w0 >= 0 && w1 >= 0 && w2 >= 0){
            w0 /= area; 
            w1 /= area; 
            w2 /= area; 
            float r = w0 * red[0] + w1 * green[0] + w2 * blue[0]; 
            float g = w0 * red[1] + w1 * green[1] + w2 * blue[1]; 
            float b = w0 * red[2] + w1 * green[2] + w2 * blue[2]; 
            float[] colors = determineColor(point);
            stroke(colors[0],colors[1],colors[2]);    
            rect(i,j,0.3,0.3);
          }            
        } 
    } 
    pop();
}

void randomizeTriangle() {
  int low = -20;
  int high = 20;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

float[] determineColor(Vector point){
  Vector[][]points = new Vector[DIVISIONS][DIVISIONS];
  float area = edgeFunction(v1, v2, v3); 
  float delta = 0.1;
  int total_pixels = DIVISIONS^2;
  float initial_x = point.x()+0.1;
  float initial_y = point.y()+0.1;
  for(int i=0;i<points.length;i++){
    for(int j=0;j<points.length;j++){
      points[j][i]= new Vector(initial_x,initial_y+delta*j);
    }
    initial_x=initial_x+delta;
  }
  float total_r=0;
  float total_g=0;
  float total_b=0;
  
  for(int i=0;i<points.length;i++){
    for(int j=0;j<points.length;j++){
      float w0 = edgeFunction(v2, v3, points[i][j]); 
      float w1 = edgeFunction(v3, v1, points[i][j]); 
      float w2 = edgeFunction(v1, v2, points[i][j]); 
      if (w0 >= 0 && w1 >= 0 && w2 >= 0) { 
      w0 /= area; 
      w1 /= area; 
      w2 /= area; 
      float r = w0 * red[0] + w1 * green[0] + w2 * blue[0]; 
      float g = w0 * red[1] + w1 * green[1] + w2 * blue[1]; 
      float b = w0 * red[2] + w1 * green[2] + w2 * blue[2]; 
      total_r+=r;
      total_g+=g;
      total_b+=b;
      }else{
      total_r+=0;
      total_g+=0;
      total_b+=0;
      }
      
    }
  }
  
    float[]final_colors ={total_r/25,total_g/25,total_b/25};
    return final_colors; 
}

void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  pop();
}

float edgeFunction(Vector v1, Vector v2, Vector v3){ 
  return (v3.x() - v1.x()) * (v2.y() - v1.y()) - (v3.y() - v1.y()) * (v2.x() - v1.x()); 
} 

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
