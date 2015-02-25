//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies


int tvx, tvy;
int animx, animy;
int deck1x, deck1y;
int deck2x, deck2y;
int deck3x, deck3y;
int deck4x, deck4y;

boolean flag;

float changeSpeed;

boolean deck1Playing = false;
boolean deck2Playing = false;
boolean deck3Playing = false;
boolean deck4Playing = false;
float rotateDeck1 = 0;
float rotateDeck2 = 0;
float rotateDeck3 = 0;
float rotateDeck4 = 0;
int counter;
float currentFrame = 0;
int margin = width/40;
PImage [] images;
PImage [] recordPlayer;
PImage TV;
Maxim maxim;
Maxim maximKey;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;
AudioPlayer playerA;
AudioPlayer playerW;
AudioPlayer playerS;
AudioPlayer playerE;
AudioPlayer playerD;
AudioPlayer playerF;
AudioPlayer playerT;
AudioPlayer playerG;
AudioPlayer playerY;
AudioPlayer playerH;
AudioPlayer playerU;
AudioPlayer playerJ;
AudioPlayer playerK;
float speedAdjust=1.0;
boolean trigger1;
boolean trigger2;
boolean trigger3;
boolean trigger4;


void setup()
{
  size(1366, 675);
  imageMode(CENTER);
  images = loadImages("Animation_data/movie", ".jpg", 134);
  recordPlayer = loadImages("black-record_", ".png", 36);
  TV = loadImage("TV.png");
  maxim = new Maxim(this);
  player1 = maxim.loadFile("variable-axis-beat.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("variable-axis-breakdown.wav");
  player2.setLooping(true);
  player2.volume(1);
  player3 = maxim.loadFile("variable-axis-no-snare.wav");
  player3.setLooping(true);
  player4 = maxim.loadFile("variable-axis-tube.wav");
  player4.setLooping(true);
  maximKey = new Maxim(this);
  playerA = maximKey.loadFile("keyA.wav");
  playerA.setLooping(false);
  playerS = maximKey.loadFile("keyS.wav");
  playerS.setLooping(false);
  playerD = maximKey.loadFile("keyD.wav");
  playerD.setLooping(false);
  playerF = maximKey.loadFile("keyF.wav");
  playerF.setLooping(false);
  playerG = maximKey.loadFile("keyG.wav");
  playerG.setLooping(false);
  playerH = maximKey.loadFile("keyH.wav");
  playerH.setLooping(false);
  playerJ = maximKey.loadFile("keyJ.wav");
  playerJ.setLooping(false);
  playerK = maximKey.loadFile("keyK.wav");
  playerK.setLooping(false);
  background(0);
  changeSpeed = 1.0;
  flag = true;
}

void draw()
{

  
  if(flag == true) {
  if((deck1Playing && !deck2Playing)||(deck2Playing && !deck1Playing))changeSpeed = changeSpeed + speedAdjust * 3;
else if(deck1Playing && deck2Playing) changeSpeed = changeSpeed + speedAdjust * 6;}
  else {
  if((deck1Playing && !deck2Playing)||(deck2Playing && !deck1Playing))changeSpeed = changeSpeed - speedAdjust * 3;
else if(deck1Playing && deck2Playing) changeSpeed = changeSpeed - speedAdjust * 6;}
   
  if(changeSpeed >= 255) flag = false;
  else if(changeSpeed <= 0) flag = true;
   
  background(changeSpeed);  
  imageMode(CENTER);
  image(images[(int)currentFrame], width/2, images[0].height/2+margin+10, images[0].width, images[0].height);
  image(TV, width/2, TV.height/2+margin+10, TV.width, TV.height);
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10)-50;
  deck1y = TV.height+recordPlayer[0].height/2+margin+30;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width, recordPlayer[0].height);
  deck2x = (width/2)+recordPlayer[0].width/2+(margin*10)+50;
  deck2y = TV.height+recordPlayer[0].height/2+margin+30;
  image(recordPlayer[(int) rotateDeck2], deck2x, deck2y, recordPlayer[0].width, recordPlayer[0].height);
  deck3x = (deck1x)-recordPlayer[0].width-(margin*10)-50;
  deck3y = TV.height+recordPlayer[0].height/2+margin+30;
  image(recordPlayer[(int) rotateDeck3], deck3x, deck3y, recordPlayer[0].width, recordPlayer[0].height);
  deck4x = (deck2x)+recordPlayer[0].width+(margin*10)+50;
  deck4y = TV.height+recordPlayer[0].height/2+margin+30;
  image(recordPlayer[(int) rotateDeck4], deck4x, deck4y, recordPlayer[0].width, recordPlayer[0].height);

  if (deck1Playing || deck2Playing) { 
    player1.speed(speedAdjust);
    player2.speed(speedAdjust);
    player3.speed(speedAdjust);
    player4.speed(speedAdjust);
    currentFrame= currentFrame+1*speedAdjust;
  }

  if (currentFrame >= images.length) {

    currentFrame = 0;
  }

  if (deck1Playing) {

    rotateDeck1 += 1*speedAdjust;

    if (rotateDeck1 >= recordPlayer.length) {

      rotateDeck1 = 0;
    }
  }

  if (deck2Playing) {

    rotateDeck2 += 1*speedAdjust;

    if (rotateDeck2 >= recordPlayer.length) {

      rotateDeck2 = 0;
    }
  }
  
  if (deck3Playing) {

    rotateDeck3 += 1*speedAdjust;

    if (rotateDeck3 >= recordPlayer.length) {

      rotateDeck3 = 0;
    }
  }
  if (deck4Playing) {

    rotateDeck4 += 1*speedAdjust;

    if (rotateDeck4 >= recordPlayer.length) {

      rotateDeck4 = 0;
    }
  }
}


void mouseClicked()
{

  //if (mouseX > (width/2)-recordPlayer[0].width-(margin*10) && mouseX < recordPlayer[0].width+((width/2)-recordPlayer[0].width-(margin*10)) && mouseY>TV.height+margin && mouseY <TV.height+margin + recordPlayer[0].height) {
  if(dist(mouseX, mouseY, deck1x, deck1y) < recordPlayer[0].width/2){
    
    deck1Playing = !deck1Playing;
  }

  if (deck1Playing) {
    player1.play();
  } 
  else {
    player1.cue(0);
    player1.stop();

  }

  if(dist(mouseX, mouseY, deck2x, deck2y) < recordPlayer[0].width/2){
  
    deck2Playing = !deck2Playing;
  }

  if (deck2Playing) {
    player2.play();
  } 
  else {
    player2.cue(0);
    player2.stop();
  }
  
  if(dist(mouseX, mouseY, deck3x, deck3y) < recordPlayer[0].width/2){
    
    deck3Playing = !deck3Playing;
  }

  if (deck3Playing) {
    player3.play();
  } 
  else {
    player3.cue(0);
    player3.stop();
  }
  
  
  if(dist(mouseX, mouseY, deck4x, deck4y) < recordPlayer[0].width/2){
    
    deck4Playing = !deck4Playing;
  }

  if (deck4Playing) {
    player4.play();
  } 
  else {
    player4.cue(0);
    player4.stop();
  }
}

void mouseDragged() {
   
 if (mouseY>height/2) {
  
   speedAdjust=map(mouseX,0,width,0,2);
   
 } 
}

void keyPressed() {
  if (keyCode == UP) {
    deck1Playing = !deck1Playing;
  } 
  if (deck1Playing) {
    player1.play();
  } 
  else {
    player1.cue(0);
    player1.stop();
  }
   
    if (keyCode == DOWN) {
    deck2Playing = !deck2Playing;
  } 
  if (deck2Playing) {
    player2.play();
  } 
  else {
    player2.cue(0);
    player2.stop();
  }
  
    if (keyCode == LEFT) {
    deck3Playing = !deck3Playing;
  } 
  if (deck3Playing) {
    player3.play();
  } 
  else {
    player3.cue(0);
    player3.stop();
  }
  
    if (keyCode == RIGHT) {
    deck4Playing = !deck4Playing;
  } 
  if (deck4Playing) {
    player4.play();
  } 
  else {
    player4.cue(0);
    player4.stop();
  }
  
  if (keyCode == ENTER ) {
    speedAdjust = 1;
  }
  switch(key) {
  case 'a': {if(playerA.isPlaying())playerA.cue(0);playerA.play();} break;
case 's': {if(playerS.isPlaying())playerS.cue(0);playerS.play();}break;
case 'd': {if(playerD.isPlaying())playerD.cue(0);playerD.play();}break;
case 'f': {if(playerF.isPlaying())playerF.cue(0);playerF.play();}break;
case 'g': {if(playerG.isPlaying())playerG.cue(0);playerG.play();}break;
case 'h': {if(playerH.isPlaying())playerH.cue(0);playerH.play();}break;
case 'j': {if(playerJ.isPlaying())playerJ.cue(0);playerJ.play();}break;
case 'k': {if(playerK.isPlaying())playerK.cue(0);playerK.play();}break;
  }
}

