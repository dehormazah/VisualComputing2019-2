//Scintillating Grid illusion//

void ScintillatingGrid(){
  background(0);
   fill(255,0,0);
    noStroke();
    for(int i = 20; i < 600; i += 40){
            rect(i,0,7,600);
    }
    for(int i = 20; i < 600; i += 40){
            rect(0,i,600,07);
    }
    for(int i = 20; i < 600; i += 40){
        for(int k = 20; k < 600; k += 40){
            fill(255);
            ellipse(i + 3,k + 3, 12,12);
        }
    }
}

void setup(){
  size(600,600);
}

void draw(){
  ScintillatingGrid();   
}
