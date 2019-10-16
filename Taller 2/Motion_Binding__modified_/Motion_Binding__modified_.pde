//Pos for lines
float L1_x_1 = 90;
float L1_y_1 = 210;
float L1_x_2 = 185;
float L1_y_2 = 300;

float L2_x_1 = 205;
float L2_y_1 = 110;
float L2_x_2 = 290;
float L2_y_2 = 195;

float L3_x_1 = 90;
float L3_y_1 = 190;
float L3_x_2 = 185;
float L3_y_2 = 110;

float L4_x_1 = 205;
float L4_y_1 = 300;
float L4_x_2 = 295;
float L4_y_2 = 210;

boolean UP_RIGTH_SET_A = true;
//Pos for set B of lines

//Green Squares?
boolean greenSquares=true;
void setup(){
size(400,400);

//BACKGROUND SETUP

//Canvas background, white
background(255);
//No stroke mode, black fill
noStroke();

}

void draw(){
fill(#7f7f7f);
rect(0, 0, 400, 400);

strokeWeight(4);
stroke(255);
//SET A OF LINES
line(L1_x_1, L1_y_1, L1_x_2, L1_y_2);
line(L2_x_1, L2_y_1, L2_x_2, L2_y_2);
//SET B OF LINES
line(L3_x_1, L3_y_1, L3_x_2, L3_y_2);
line(L4_x_1, L4_y_1, L4_x_2, L4_y_2);

fill(#5eff0b);
if(greenSquares){
noStroke();
quad(30, 200, 80, 150, 130, 200, 80, 250);
quad(270, 200, 320, 150, 370, 200, 320, 250);
quad(145, 315, 195, 265, 245, 315, 195, 365);
quad(145, 100, 195, 50, 245, 100, 195, 150);
}
if(UP_RIGTH_SET_A){
  L1_x_1 += 0.2;
  L1_x_2 += 0.2;
  L1_y_1 -= 0.2;
  L1_y_2 -= 0.2;
  
  L2_x_1 += 0.2;
  L2_x_2 += 0.2;
  L2_y_1 -= 0.2;
  L2_y_2 -= 0.2;
  
  L3_x_1 += 0.2;
  L3_x_2 += 0.2;
  L3_y_1 += 0.2;
  L3_y_2 += 0.2;
  
  L4_x_1 += 0.2;
  L4_x_2 += 0.2;
  L4_y_1 += 0.2;
  L4_y_2 += 0.2;
}else{
  L1_x_1 -= 0.2;
  L1_x_2 -= 0.2;
  L1_y_1 += 0.2;
  L1_y_2 += 0.2;
  
  L2_x_1 -= 0.2;
  L2_x_2 -= 0.2;
  L2_y_1 += 0.2;
  L2_y_2 += 0.2;
  
  L3_x_1 -= 0.2;
  L3_x_2 -= 0.2;
  L3_y_1 -= 0.2;
  L3_y_2 -= 0.2;
  
  L4_x_1 -= 0.2;
  L4_x_2 -= 0.2;
  L4_y_1 -= 0.2;
  L4_y_2 -= 0.2;
}
if(L1_x_1 > 100){
  UP_RIGTH_SET_A=false;
}
if(L1_x_1 < 80){
  UP_RIGTH_SET_A=true;
}
}
   





void mouseClicked() {
  greenSquares = !greenSquares;
}
