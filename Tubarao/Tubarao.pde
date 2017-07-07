PShape tubarao;
PShape atum1,atum2;
PShape lula1,lula2;
PImage fundo;

int posTubarao = 10;
int estadoAtum = 0;
int estadoLula = 0;
float xAtum;
float yAtum;
float xLula;
float yLula;

void setup() {
  size(800, 600);
  //frameRate(5);
  //fullScreen();
  // The file "bot1.svg" must be in the data folder
  // of the current sketch to load successfully
  tubarao = loadShape("tubarao.svg");
  atum1 = loadShape("atum1.svg");
  atum2 = loadShape("atum2.svg");
  lula1 = loadShape("lula1.svg");
  lula2 = loadShape("lula2.svg");
  fundo = loadImage("fundo.jpg");
  xAtum = width-80;
  yAtum = random(10.0,height-50.0);
  xLula = width-80;
  yLula = random(10.0,height-50.0);
}
int dPos = 2;
int qualAtum = 1;
int qualLula = 1;
void draw(){
  background(fundo);
  if(qualAtum == 1){
    shape(atum1, xAtum, yAtum, 72, 44);  // Draw at coordinate (110, 90) at size 100 x 100
  } else {
    shape(atum2, xAtum, yAtum, 72, 44);  // Draw at coordinate (110, 90) at size 100 x 100
  }
  if(qualLula == 1){
    shape(lula1, xLula, yLula, 78, 115);  // Draw at coordinate (110, 90) at size 100 x 100
  } else {
    shape(lula2, xLula, yLula, 113, 100);  // Draw at coordinate (110, 90) at size 100 x 100
  }
  shape(tubarao, 10, posTubarao, 254, 130);  // Draw at coordinate (110, 90) at size 100 x 100
  if(xAtum<10){
    xAtum = width;
    yAtum = random(10.0,height-50.0);
  } else {
    xAtum = xAtum - dPos;
  }
  if(xLula<10){
    xLula = width;
    yLula = random(10.0,height-50.0);
  } else if (qualLula ==2){
    xLula = xLula - 2.2*dPos;
  }
  estadoAtum = estadoAtum +1;
  if(estadoAtum<20)
    qualAtum = 1;
  else if(estadoAtum<40)
    qualAtum = 2;
  else
    estadoAtum = 0;
  estadoLula = estadoLula +1;
  if(estadoLula<40)
    qualLula = 1;
  else if(estadoLula<80)
    qualLula = 2;
  else
    estadoLula = 0;
  if(keyPressed){
    if (key == CODED) {
      if (keyCode == DOWN) {
        if(posTubarao<height-130-10){
          posTubarao = posTubarao + dPos;
        }
      } else if (keyCode == UP) {
        if(posTubarao>10){
          posTubarao = posTubarao - dPos;
        }
      }
    }
  }
}
