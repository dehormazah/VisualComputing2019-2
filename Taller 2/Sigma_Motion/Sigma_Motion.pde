//Sigma motion 
int state=2000;
void sigma_motion(){
  int a =100;
  for(int x=0;x<a;++x){
    background(0);
  }

  for(int x=0;x<800/25;++x){
    int theme = ( (state%2 == 0 && x%2 == 0) || ( state%2 != 0 && x%2 == 1) ) ? 255 : 0;
    fill(theme);
    stroke(theme);
    rect(25*x,0,100,800);
  }
  state = (state+1)%100;
}
void setup(){
  size(600,100);
}

void draw(){
  sigma_motion();   
}
