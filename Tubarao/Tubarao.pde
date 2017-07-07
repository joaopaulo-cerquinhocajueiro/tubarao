PShape tubarao;
PShape atum1,atum2;
PShape lula1,lula2;
PImage fundo;

 // Posição do tubarão
int posTubarao = 10;
// Variáveis para contar os frames do atum e da lula para fazer a animação
int estadoAtum = 0;
int estadoLula = 0;
int qualAtum = 1;
int qualLula = 1;
//Posições das comidas na tela
float xAtum;
float yAtum;
float xLula;
float yLula;
// O quanto o tubarão anda a cada frame
int dPos = 2;
// Se atum ou lula foram comidos
boolean comeuAtum = false;
boolean comeuLula = false;

PFont f;
int pontuacao = 0;

void setup() {
  f = createFont("Arial",20);
  textFont(f);

  // Tamanho da tela do jogo
  size(800, 600);
  // Carrega as formas. Para o processing tem que estar no diretório 'data'
  tubarao = loadShape("tubarao.svg");
  atum1 = loadShape("atum1.svg");
  atum2 = loadShape("atum2.svg");
  lula1 = loadShape("lula1.svg");
  lula2 = loadShape("lula2.svg");
  fundo = loadImage("fundo.jpg");
  //Define as posições iniciais do atum e da lula
  xAtum = width-80;
  yAtum = random(10.0,height-50.0);
  xLula = width-80;
  yLula = random(10.0,height-50.0);
}

void draw(){
  // Carrega a imagem de fundo
  background(fundo);

  // Checa se tubarao comeu ou não o atum ou a lula
  if(xAtum<250 && xAtum>190 && yAtum<posTubarao+80 && yAtum+40>posTubarao+80){
    comeuAtum = true;
    pontuacao = pontuacao+2;
  }
  if(xLula<250 && xLula>200 && yLula<posTubarao+80 && yLula+60>posTubarao+80){
    comeuLula = true;
    pontuacao = pontuacao+5;
  }

  // Desenha o atum e a lula
  if(!comeuAtum){
    if(qualAtum == 1){
      shape(atum1, xAtum, yAtum, 72, 44);
    } else if(qualAtum == 2){
      shape(atum2, xAtum, yAtum, 72, 44);
    }
  }
  if(!comeuLula){
    if(qualLula == 1){
      shape(lula1, xLula, yLula, 78, 115);
    } else if(qualLula == 2){
      shape(lula2, xLula, yLula, 113, 100);
    }
  }
  // Desenha o tubarão
  shape(tubarao, 10, posTubarao, 254, 130);
  // stroke(200,0,0);
  // strokeWeight(4);
  // noFill();
  // point(250,posTubarao+80);
  // strokeWeight(2);
  // rect(xLula,yLula,50,60);
  // rect(xAtum,yAtum,60,40);
  text("pontos: "+pontuacao,width-130,20);
  if((xAtum<10)){ // Se atum chegou no fim da tela
    // Inicializa novo atum
    comeuAtum = false;
    xAtum = width;
    yAtum = random(10.0,height-50.0);
  } else { // Se não, atum anda
    xAtum = xAtum - dPos;
  }
  if(xLula<10){ // Se lula chegou no fim da tela ou se morreu
    // Inicializa nova lula
    comeuLula = false;
    xLula = width;
    yLula = random(10.0,height-50.0);
  } else if (qualLula ==2){ // Lula só anda se for lula2
    xLula = xLula - 2.2*dPos;
  }
  // Atualiza o estado e o desenho do atum
  estadoAtum = estadoAtum +1;
  if(estadoAtum<20)
    qualAtum = 1;
  else if(estadoAtum<40)
    qualAtum = 2;
  else
    estadoAtum = 0;
  // Atualiza o estado e o desenho da lula
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
        paraBaixo();
      } else if (keyCode == UP) {
        paraCima();
      }
    }
  }
  if(mousePressed==true && mouseX<270){
    if (mouseY<height/2){
      paraCima();
    } else {
      paraBaixo();
    }
  }
}

void paraBaixo(){
  if(posTubarao<height-130-10){
    posTubarao = posTubarao + dPos;
  }
}
void paraCima() {
  if(posTubarao>10){
    posTubarao = posTubarao - dPos;
  }
}
