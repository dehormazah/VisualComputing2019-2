
void setup(){
size(400,320);
}

void draw(){
//Canvas background
background(255);

//No stroke mode
noStroke();
int plusHeigth = mouseY;
int mapPlusHeigth=int(map(plusHeigth,0,300,0,22));
//rd = dist(0,0,mouseX,mouseY)/100;
if(mapPlusHeigth > 20){
 mapPlusHeigth = 20;
}  


fill(#424242);
rect(167, 40, 50, 30+mapPlusHeigth);

fill(#565656);
rect(140, 90, 100, 30+mapPlusHeigth);

fill(#7a7a7a);
rect(115, 140, 150, 30+mapPlusHeigth);

fill(#989898);
rect(90, 190, 200, 30+mapPlusHeigth);

fill(#b6b6b6);
rect(70, 240, 250, 30+mapPlusHeigth);



}
