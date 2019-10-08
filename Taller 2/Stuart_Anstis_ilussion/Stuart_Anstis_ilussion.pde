//X-pos for cars
float a = 0; 

//Left to rigth? 
boolean LtR = true;

//Black bars?
boolean blackBars=true;
void setup(){
size(800,400);

//BACKGROUND SETUP

//Canvas background, white
background(255);
//No stroke mode, black fill
noStroke();

}

void draw(){
fill(255);
rect(0, 0, 800, 400);

fill(0);
if(blackBars){
for(int i=0; i<800; i+=40){
rect(i, 0, 20, 400);
}
}
   
fill(#ffff00);
rect(a, 100, 80, 40);
fill(#000060);
rect(a, 200, 80, 40);
if (LtR){
a = a + 0.7;
}else{
a = a - 0.7;
}

if( a > 720 ){
  LtR = false;
}else{
  if( a < 0){
  LtR = true;
  }
}

}

void mouseClicked() {
  blackBars = !blackBars;  
}
