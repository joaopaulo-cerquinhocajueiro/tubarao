PShape tubarao;
PShape atum1,atum2;
PShape lula1,lula2;
PShape camaroes,camarao1,camarao2;
PImage fundo;

 // Posição do tubarão
int posTubarao = 10;
// Variáveis para contar os frames do atum e da lula para fazer a animação
int estadoAtum = 0;
int estadoLula = 0;
int estadoCamarao = 0;
int qualAtum = 1;
int qualLula = 1;
int qualCamarao = 1;
//Posições das comidas na tela
float xAtum;
float yAtum;
float xLula;
float yLula;
float xCamarao;
float yCamarao;
// O quanto o tubarão anda a cada frame
int dPos = 2;
// Se atum ou lula foram comidos
boolean comeuAtum = false;
boolean comeuLula = false;
boolean comeuCamarao = false;

//Indicador de quanto tempo falta no jogo
float tempo = 700.0;


PFont f;
int pontuacao = 0;

int tela = 0;

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
  camaroes = loadShape("camaroes.svg");
  camarao1 = camaroes.getChild("camarao1");
  camarao2 = camaroes.getChild("camarao2");
  fundo = loadImage("fundo.jpg");
  
  //Define as posições iniciais dos atum, lula e camarão
  xAtum = width-80;
  yAtum = random(10.0,height-50.0);
  xLula = width-80;
  yLula = random(10.0,height-50.0);
  xCamarao = width-80;
  yCamarao = random(10.0,height-50.0);
  
}

void draw(){
  if(tela==1){
    // Carrega a imagem de fundo
    background(fundo);
  
    // Checa se tubarao comeu ou não algum bich
    if(xAtum<250 && xAtum>190 && yAtum<posTubarao+80 && yAtum+40>posTubarao+80){
      comeuAtum = true;
      pontuacao = pontuacao+2;
      tempo = tempo + 2;
    }
    if(xLula<250 && xLula>200 && yLula<posTubarao+80 && yLula+60>posTubarao+80){
      comeuLula = true;
      pontuacao = pontuacao+5;
      tempo = tempo + 5;
    }
    if(xCamarao<250 && xCamarao>200 && yCamarao<posTubarao+80 && yCamarao+50>posTubarao+80){
      comeuCamarao = true;
      pontuacao = pontuacao+1;
      tempo = tempo + 1;
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
    if(!comeuCamarao){
      if(qualCamarao == 1){
        shape(camarao1,xCamarao-110,yCamarao-110,76,100);
      } else if(qualCamarao == 2){
        shape(camarao2,xCamarao-110,yCamarao-110+50,76,100);
      }
    }
    // Desenha o tubarão
    shape(tubarao, 10, posTubarao, 254, 130);
     //stroke(200,0,0);
     //strokeWeight(4);
     //noFill();
     //point(250,posTubarao+80);
     //strokeWeight(2);
     //rect(xLula,yLula,50,60);
     //rect(xAtum,yAtum,60,40);
     //rect(xCamarao,yCamarao,50,50);
     fill(255);
     
     // Marcação de quanto tempo falta
     text("pontos: "+pontuacao,width-130,20);
     fill(0,100,200);
     noStroke();
     rect(0,height-20,tempo*width/1000.0,20);
     tempo = tempo-0.1-0.001*pontuacao;
     if(tempo<=0){
       tela = 2;
     }
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
    if(xCamarao<2){ // Se lula chegou no fim da tela ou se morreu
      // Inicializa nova lula
      comeuCamarao = false;
      xCamarao = width;
      yCamarao = random(10.0,height-50.0);
    } else { 
      xCamarao = xCamarao - 0.7*dPos;
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
    // Atualiza o estado e o desenho do camarao
    estadoCamarao = estadoCamarao +1;
    if(estadoCamarao<15)
      qualCamarao = 1;
    else if(estadoCamarao<30)
      qualCamarao = 2;
    else {
      estadoCamarao = 0;
      yCamarao = yCamarao + random(-10,+10);
    }
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
  } else if(tela==0){
    background(0);
    fill(255);
    textAlign(CENTER,CENTER);
    text("Jogo do tubarão",width/2,height/2);
    rect(width/2-100,height/2+35,200,30);
    fill(0);
    text("Estou com fome",width/2,height/2+50);
    if(mousePressed==true && mouseX<width/2+100 && mouseX>width/2-100){
      if (mouseY<height/2+65 && mouseY>height/2+35){
        tela = 1;
      }
    }
  } else if(tela==2){
    background(0,0,100);
    fill(255);
    textAlign(CENTER,CENTER);
    text("Estou satisfeito!",width/2,height/2-50);
    text("pontos: "+pontuacao,width/2,height/2);
    rect(width/2-100,height/2+35,200,30);
    fill(0);
    text("Ainda tenho fome",width/2,height/2+50);
    if(mousePressed==true && mouseX<width/2+100 && mouseX>width/2-100){
      if (mouseY<height/2+65 && mouseY>height/2+35){
        tela = 1;
        pontuacao = 0;
      }
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