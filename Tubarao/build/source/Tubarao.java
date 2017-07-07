import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Tubarao extends PApplet {

PShape tubarao;
PShape atum1,atum2;
PShape lula1,lula2;
PImage fundo;

 // Posi\u00e7\u00e3o do tubar\u00e3o
int posTubarao = 10;
// Vari\u00e1veis para contar os frames do atum e da lula para fazer a anima\u00e7\u00e3o
int estadoAtum = 0;
int estadoLula = 0;
int qualAtum = 1;
int qualLula = 1;
//Posi\u00e7\u00f5es das comidas na tela
float xAtum;
float yAtum;
float xLula;
float yLula;
// O quanto o tubar\u00e3o anda a cada frame
int dPos = 2;
// Se atum ou lula foram comidos
boolean comeuAtum = false;
boolean comeuLula = false;

PFont f;
int pontuacao = 0;

public void setup() {
  f = createFont("Arial",20);
  textFont(f);

  // Tamanho da tela do jogo
  
  // Carrega as formas. Para o processing tem que estar no diret\u00f3rio 'data'
  tubarao = loadShape("tubarao.svg");
  atum1 = loadShape("atum1.svg");
  atum2 = loadShape("atum2.svg");
  lula1 = loadShape("lula1.svg");
  lula2 = loadShape("lula2.svg");
  fundo = loadImage("fundo.jpg");
  //Define as posi\u00e7\u00f5es iniciais do atum e da lula
  xAtum = width-80;
  yAtum = random(10.0f,height-50.0f);
  xLula = width-80;
  yLula = random(10.0f,height-50.0f);
}

public void draw(){
  // Carrega a imagem de fundo
  background(fundo);

  // Checa se tubarao comeu ou n\u00e3o o atum ou a lula
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
  // Desenha o tubar\u00e3o
  shape(tubarao, 10, posTubarao, 254, 130);
  // stroke(200,0,0);
  // strokeWeight(4);
  // noFill();
  // point(250,posTubarao+80);
  // strokeWeight(2);
  // rect(xLula,yLula,50,60);
  // rect(xAtum,yAtum,60,40);
  text("pontos:"+pontuacao,width-100,20);
  if((xAtum<10)){ // Se atum chegou no fim da tela
    // Inicializa novo atum
    comeuAtum = false;
    xAtum = width;
    yAtum = random(10.0f,height-50.0f);
  } else { // Se n\u00e3o, atum anda
    xAtum = xAtum - dPos;
  }
  if(xLula<10){ // Se lula chegou no fim da tela ou se morreu
    // Inicializa nova lula
    comeuLula = false;
    xLula = width;
    yLula = random(10.0f,height-50.0f);
  } else if (qualLula ==2){ // Lula s\u00f3 anda se for lula2
    xLula = xLula - 2.2f*dPos;
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
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Tubarao" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
