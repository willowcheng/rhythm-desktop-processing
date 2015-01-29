//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies


int tvx, tvy;
int animx, animy;
int deck1x, deck1y;
int deck2x, deck2y;

boolean flag;

float changeSpeed;

boolean deck1Playing = false;
boolean deck2Playing = false;
float rotateDeck1 = 0;
float rotateDeck2 = 0;
float currentFrame = 0;
int margin = width/40;
PImage [] images;
PImage [] recordPlayer;
PImage TV;
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;
float speedAdjust=1.0;


void setup()
{
  size(1366, 675);
  imageMode(CENTER);
  images = loadImages("Animation_data/movie", ".jpg", 134);
  recordPlayer = loadImages("black-record_", ".png", 36);
  TV = loadImage("TV.png");
  maxim = new Maxim(this);
  player1 = maxim.loadFile("beat1.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("beat2.wav");
  player2.setLooping(true);
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
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10);
  deck1y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck1], deck1x-50, deck1y+30, recordPlayer[0].width, recordPlayer[0].height);
  deck2x = (width/2)+recordPlayer[0].width/2+(margin*10);
  deck2y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck2], deck2x+50, deck2y+30, recordPlayer[0].width, recordPlayer[0].height);

  if (deck1Playing || deck2Playing) { 
    player1.speed(speedAdjust);
    player2.speed((player2.getLengthMs()/player1.getLengthMs())*speedAdjust);
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

    player1.stop();
  }

  if(dist(mouseX, mouseY, deck2x, deck2y) < recordPlayer[0].width/2){
  
    deck2Playing = !deck2Playing;
  }

  if (deck2Playing) {
    player2.play();
  } 
  else {

    player2.stop();
  }
}

void mouseDragged() {
   
 if (mouseY>height/2) {
  
   speedAdjust=map(mouseX,0,width,0,2);
   
 } 
}
