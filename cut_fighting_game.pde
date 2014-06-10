/*写真から格闘アニメーションを再現してくれるプログラムです
アニメーションの追加はキャラクタークラス(Chatactor.pde)に記載しています
*/
public final static int GRAND_LINE_Y = 350;//キャラクターの水平位置
Charactor man;//表示されるキャラクター
Button buttonWalkL;//左に歩くボタン
Button buttonWalkR;//右に歩くボタン
Button buttonJump;//ジャンプボタン
Button buttonKick;//キックボタン
Button buttonPanch;//パンチボタン
Button start;//スタートボタン
boolean startFlag = false;//OpenCVを呼び出して終了までブランクがあるのでそのための待機画面を表示するフラグ
PImage src_back;//背景
int t = 0;//時間カウンタ
int u = 1000;//アニメーションのコマとび防止のための初期値

void setup() {
  //OpenCVのプログラム呼び出し
  //open("C:/Users/rocky/Documents/Visual Studio 2010/Projects/parts_cut/Debug/parts_cut.exe");
  //背景ランダム表示
  int i = (int)random(20) % 13;
  src_back = loadImage(i + ".jpg");
  //画面サイズ
  size(1200,400);
  frameRate(60);
  //ボタンインスタンス化
  buttonWalkL = new Button(0,200,"walkL", "red");
  buttonWalkR = new Button(0,300,"walkR", "blue");
  buttonJump = new Button(1100,100,"jump", "yellow");
  buttonKick = new Button(1100,200,"kick", "green");
  buttonPanch = new Button(1100,300,"panch","cian");
  start = new Button (width/2-50,height/2-50,"start","purple");
  //キャラクターインスタンス化
  man = new Charactor();
}

void draw() {
  
  background(0);
  if(startFlag){
  image(src_back,100,-300,1000,700);
//  drawGrid(50);
  //キー入力対応
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
  
  //マウスのボタン入力対応
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
  
  //アクション実行（描画）
  man.action();
  //描画
  buttonWalkL.draw();
  buttonWalkR.draw();
  buttonJump.draw();
  buttonKick.draw();
  buttonPanch.draw();
  
  t++;
  
  } else {
    //初期待機画面のボタンを消すかどうか
    if(mousePressed == true) {
      if(start.onButton(mouseX,mouseY)){
        startFlag = true;
        start.kill();
      }
    }
    start.draw();
  }
}

//グリッド線を描画（デバッグ用）
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

//地平線（赤）を描画（デバッグ用）
public void drawGroundLine() {
    stroke(255, 0, 0);
    strokeWeight(5);
    line(0, GRAND_LINE_Y, width, GRAND_LINE_Y);
}




