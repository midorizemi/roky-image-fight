public final static int GRAND_LINE_Y = 350;
Charactor man;
Button buttonWalkL;
Button buttonWalkR;
Button buttonJump;
Button buttonKick;
Button buttonPanch;
Button start;
boolean startFlag = false;
PImage src_back;
int t = 0;//時間カウンタ
int u = 1000;

void setup() {
  //open("C:/Users/rocky/Documents/Visual Studio 2010/Projects/parts_cut/Debug/parts_cut.exe");
  int i = (int)random(20) % 13;
  src_back = loadImage(i + ".jpg");
  size(1200,400);
  frameRate(30);
  buttonWalkL = new Button(0,200,"walkL", "red");
  buttonWalkR = new Button(0,300,"walkR", "blue");
  buttonJump = new Button(1100,100,"jump", "yellow");
  buttonKick = new Button(1100,200,"kick", "green");
  buttonPanch = new Button(1100,300,"panch","cian");
  start = new Button (width/2-50,height/2-50,"start","puple");
  man = new Charactor();
}

void draw() {
  
  background(0);
  if(startFlag){
  image(src_back,100,-300,1000,700);
//  drawGrid(50);
  
  if (keyPressed == true) {
    if(key == 'l'){
      man.startAction("wolkL");
    }
    if(key == 'h'){
      man.startAction("wolkR");
    }
    if(key == 'k'){
      man.startAction("kick");
    }
  if(key == 'p'){
      man.startAction("panch");
    }
  if(key == 'j'){
      man.startAction("jump");
    }
  }

  if(mousePressed == true) {
    if(buttonWalkL.onButton(mouseX,mouseY)){
      man.startAction("wolkL");
    }
    if(buttonWalkR.onButton(mouseX,mouseY)){
      man.startAction("wolkR");
    }
    if(buttonJump.onButton(mouseX,mouseY)){
      man.startAction("jump");
    }
    if(buttonKick.onButton(mouseX,mouseY)){
      man.startAction("kick");
    }
    if(buttonPanch.onButton(mouseX,mouseY)){
      man.startAction("panch");
    }
  }
  
  man.action();
  buttonWalkL.draw();
  buttonWalkR.draw();
  buttonJump.draw();
  buttonKick.draw();
  buttonPanch.draw();
  t++;
  } else {
    if(mousePressed == true) {
      if(start.onButton(mouseX,mouseY)){
        startFlag = true;
        start.kill();
      }
    }
    start.draw();
  }
}


private void  drawGrid(int spece) {
  stroke(0);
  strokeWeight(1);
  for (int i = 0; i <= height ; i+=spece) {
    line(0, i, width, i);
  }
  for (int j = 0; j <= width ; j+=spece) {
    line(j, 0, j, height);
  }
}

public void drawGroundLine() {
    stroke(255, 0, 0);
    strokeWeight(5);
    line(0, GRAND_LINE_Y, width, GRAND_LINE_Y);
}




