/*アニメーションの追加はアニメーションメソッドを実装します．
既存のアニメーションメソッドをコピーペーストするといいでしょう．
各コマで細かい位置を変更したい場合はそのコマを表示する実装を
PshuMatrix(),PopMatrix()で囲みその中でtransrate(),rotate()を実装します．
*/
import java.util.Map;
public class Charactor {
  int x = width / 2, y;
  int direction = 1; //画面を基準とし右方向を正，左を負とする．値は1もしくは-1しか持たない．
  float w;
  final Map<String, Boolean> actionFlag = setActionFlag(); //各アクションのフラグ. actionFlag.get("stand")で取得可能

  //各パーツの描画基本座標はdataディレクトリのキャラクターパーツサンプル.pngを参照
  ArmR armR = new ArmR();
  ArmL armL = new ArmL();
  LegR legR = new LegR();
  LegL legL = new LegL();
  BodyF bodyF = new BodyF();
  BodyS bodyS = new BodyS();

  //コンストラクタ立ち設定位置を地面に
  public Charactor() {
    setStandardPosition();
  }

  //平行移動
  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  //水平移動
  void moveHorizontally(int x) {
    this.x = x;
  }
  
  //キャラクター（首原点）の回転
  void setW(int w) {
    this.w = w;
  }

  //左へ向き変更
  void turnLeftDirection() {
    direction = 1;
  }
  
  //右へ向き変更
  void turnRightDirection() {
    direction = -1;
  }

  //立ち位置を地面に初期化
  void setStandardPosition() {
    moveHorizontally(x);
    y = GRAND_LINE_Y - (bodyF.getBodyHeight() + bodyS.getBodyHeight()) / 2 - (legR.getHeight() + legL.getHeight()) / 2;
    setW(0);
  }

  //各パーツの座標を初期化
  void Partsinitialize() {
    armR.initialize();
    armL.initialize();
    legR.initialize();
    legL.initialize();
    bodyF.initialize();
    bodyS.initialize();
  }
  
  //アクションメソッド
  //すべてのメソッドが実行される．ただし各アニメーションの実行は対応のアクションフラグで制御
  void action() {
    pushMatrix();
    translate(x, y);
    rotate(radians(w));
    stand();
    wolkL();
    wolkR();
    jump();
    panch();
    kick();
    popMatrix();
  }
  
  //アクションフラグの初期化
  HashMap setActionFlag() {
    HashMap flag = new HashMap();
    flag.put("stand", true);
    flag.put("wolkL", false);
    flag.put("wolkR", false);
    flag.put("jump", false);
    flag.put("panch", false);
    flag.put("kick", false);

    return flag;
  }

  //ボタンを押すとアクションフラグを変更する
  void startAction(String action) {
    this.actionFlag.put(action, true);
    for (Map.Entry e : actionFlag.entrySet()) {
      if (e.getKey().equals(action)) {//引数で指定したアクション以外のフラグを倒す
        continue;
      }
      e.setValue(false);
    }
  }
  
  //待機アニメーション（ただの直立）
  void stand() {
    scale(direction, 1);
    if (actionFlag.get("stand")) { 
      armL.setW(70);
      armL.setXY(bodyF.getWidth()/3+8, 0);
      armL.draw();
      legL.setXY(0, bodyF.getBodyHeight()-1);
      legL.draw();
      legR.setXY(0, bodyF.getBodyHeight()-1);
      legR.draw();
      bodyF.setXY(0, 0);
      bodyF.draw();
      armR.setW(-55);
      armR.setXY(-bodyF.getWidth()/3-2, 4);
      armR.draw();
    }
  }
  
  //左へ歩く
  void wolkL() {
    if (actionFlag.get("wolkL")) {
      turnLeftDirection();
      Partsinitialize();
      if (t<10) {
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        legL.setW(-6);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight());
        legL.draw();
        legL.setW(3);
        legL.setXY(0, bodyS.getBodyHeight() - 1);
        legL.draw();
        bodyS.setW(0);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
      } 
      else if (t<25) {
        pushMatrix();
        translate(0, 2);//よりアニメーションらしさをだすために微調整
        armR.setW(-139);
        armR.setXY(0, bodyS.getHeadHeight());
        armR.draw();
        legL.setW(10);
        legL.setXY(-bodyS.getWidth() / 8 + 3, bodyS.getBodyHeight() - 4);
        legL.draw();
        legL.setW(-10);
        legL.setXY(2, bodyS.getBodyHeight() - 1);
        legL.draw();
        bodyS.setW(0);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(100);
        armL.setXY(bodyS.getWidth() / 2 - 10, bodyS.getHeadHeight() - 6);
        armL.draw();
        popMatrix();
      } 
      else if (t<35) {
        legL.setW(2);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight() - 1);
        legL.draw();
        legL.setW(-5);
        legL.setXY(1, bodyS.getBodyHeight() - 1);
        legL.draw();
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        bodyS.setW(0);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
      } 
      else if (t<50) {
        pushMatrix();
        translate(0, 2);
        armR.setW(-73);
        armR.setXY(-3, bodyS.getHeadHeight()-5);
        armR.draw();
        legL.setW(-16);
        legL.setXY(-bodyS.getWidth() / 8, bodyS.getBodyHeight() - 1);
        legL.draw();
        legL.setW(9);
        legL.setXY(-bodyS.getWidth() / 6, bodyS.getBodyHeight() - 4);
        legL.draw();
        bodyS.setW(0);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(30);
        armL.setXY(bodyS.getWidth() / 2 - 10, bodyS.getHeadHeight() - 6);
        armL.draw();
        popMatrix();
      } 
      else {
        legL.setW(-6);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight());
        legL.draw();
        legL.setW(3);
        legL.setXY(0, bodyS.getBodyHeight() - 1);
        legL.draw();
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        bodyS.setW(0);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
        actionFlag.put("wolkL", false);
        actionFlag.put("stand", true);
        setStandardPosition();
        t = 0;
      }
      x+=1;
    }
  }
  
  //右に歩く
  void wolkR() {
    if (actionFlag.get("wolkR")) {
      turnRightDirection();
      Partsinitialize();
      if (t<10) {
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        legL.setW(-6);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight());
        legL.draw();
        legL.setW(3);
        legL.setXY(0, bodyS.getBodyHeight() - 1);
        legL.draw();
        bodyS.setW(-1);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
      } 
      else if (t<25) {
        pushMatrix();
        translate(0, 2);
        armR.setW(-139);
        armR.setXY(0, bodyS.getHeadHeight());
        armR.draw();
        legL.setW(10);
        legL.setXY(-bodyS.getWidth() / 8 + 3, bodyS.getBodyHeight() - 4);
        legL.draw();
        legL.setW(-10);
        legL.setXY(2, bodyS.getBodyHeight() - 1);
        legL.draw();
        bodyS.setXY(0, 0);
        bodyS.setW(-1);
        bodyS.draw();
        armL.setW(100);
        armL.setXY(bodyS.getWidth() / 2 - 10, bodyS.getHeadHeight() - 6);
        armL.draw();
        popMatrix();
      } 
      else if (t<35) {
        legL.setW(2);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight() - 1);
        legL.draw();
        legL.setW(-5);
        legL.setXY(1, bodyS.getBodyHeight() - 1);
        legL.draw();
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        bodyS.setW(-1);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
      } 
      else if (t<50) {
        pushMatrix();
        translate(0, 2);
        armR.setW(-73);
        armR.setXY(-3, bodyS.getHeadHeight()-5);
        armR.draw();
        legL.setW(-16);
        legL.setXY(-bodyS.getWidth() / 8, bodyS.getBodyHeight() - 1);
        legL.draw();
        legL.setW(9);
        legL.setXY(-bodyS.getWidth() / 6, bodyS.getBodyHeight() - 4);
        legL.draw();
        bodyS.setW(-1);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(30);
        armL.setXY(bodyS.getWidth() / 2 - 10, bodyS.getHeadHeight() - 6);
        armL.draw();
        popMatrix();
      } 
      else {
        legL.setW(-6);
        legL.setXY(-bodyS.getWidth() / 8 + 2, bodyS.getBodyHeight());
        legL.draw();
        legL.setW(3);
        legL.setXY(0, bodyS.getBodyHeight() - 1);
        legL.draw();
        armR.setW(-100);
        armR.setXY(-bodyS.getWidth() / 3, 4);
        armR.draw();
        bodyS.setW(-1);
        bodyS.setXY(0, 0);
        bodyS.draw();
        armL.setW(75);
        armL.setXY(bodyS.getWidth() / 2 - 10, 4);
        armL.draw();
        actionFlag.put("wolkR", false);
        actionFlag.put("stand", true);
        setStandardPosition();
        t = 0;
      }
      x-=1;
    }
  }
  
  //キック
  void kick() {
    if (actionFlag.get("kick")) { 
      Partsinitialize();
      if (u == 1000){
        u = t; 
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();       
      }else if((t-u)<10) {   
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
      }else if ((t-u)<20) {
        bodyF.setXY(0, 0);
        armL.setW(70);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armR.setW(-55);
        legL.setXY(-3, bodyF.getBodyHeight()+4);
        legL.setW(-45);
        legR.setXY(0, bodyF.getBodyHeight()-1);
        armR.draw();
        armL.draw();
        legR.draw();
        legL.draw();
        bodyF.draw();
        armR.draw();
      }
      else if ((t-u)<45) {
        pushMatrix();
        translate(25, 6);
        rotate(radians(15));
        bodyS.setXY(-3, -3);
        armL.setW(70);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armL.setXY(bodyF.getWidth()/4, -3);
        armR.setW(-55);
        armL.setW(62);
        legL.setXY(1, bodyF.getBodyHeight()+14);
        legL.setW(-100);
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.setW(-3);
        armR.draw();
        armL.draw();
        legR.draw();
        legL.draw();
        bodyS.draw();
        armR.draw();
        popMatrix();
        setStandardPosition();
      }
      else {
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
        actionFlag.put("kick", false);
        actionFlag.put("stand", true);
        setStandardPosition();
        t = 0;
        u =1000;
      }
    }
  }
  
  //パンチ
  void panch(){
    if (actionFlag.get("panch")) { 
      Partsinitialize();
      if (u == 1000){
        u = t;
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
      }else if((t-u)<10){
        Partsinitialize();//初期化が必要 
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
      }
      else if((t-u)<20){
        bodyF.setXY(0,0);
        armL.setW(70);
        armR.setXY(-bodyF.getWidth()/3,0);
        armL.setXY(bodyF.getWidth()/3+8,0);
        armR.setW(0);
        legL.setXY(0,bodyF.getBodyHeight()-1);
        legL.setW(-15);
        legR.setXY(0,bodyF.getBodyHeight()-1);
        armL.draw();
        legR.draw();
        legL.draw();
        bodyF.draw();
        armR.draw();
      }
      else if((t-u)<45){
        pushMatrix();
        translate(45,5);
        rotate(radians(25));
        bodyS.setXY(-1,-4);
        armL.setW(105);
        armR.setXY(-bodyF.getWidth()/3+3,-2);
        armL.setXY(bodyF.getWidth()/3-2,5);
        armR.setW(30);
        legL.setXY(0,40);
        legL.setW(-15);
        legR.setXY(5,38);
        legR.setW(-20);
        armL.draw();
        scale(-1,1);
        legR.draw();
        scale(-1,1);
        legL.draw();
        bodyS.draw();
        scale(-1,1);
        armR.draw();
        scale(-1,1);
        setStandardPosition();
        popMatrix();
      }
      else{
        setStandardPosition();
        Partsinitialize();//初期化が必要 
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
        actionFlag.put("panch", false);//こんな感じ？
        actionFlag.put("stand", true);
        t = 0;
        u = 1000;
      }
    }
  }
  
  //ジャンプ
  void jump(){
    if (actionFlag.get("jump")) { 
      Partsinitialize();
      if(u == 1000){
        u = t;
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
      }else if((t-u)<5){
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
      }
      else if((t-u)<20){
        pushMatrix();
        translate(0,-8);
        bodyF.setXY(0,0);
        armL.setW(0);
        armR.setW(0);
        armR.setXY(-bodyF.getWidth()/3,0);
        armL.setXY(bodyF.getWidth()/3,0);
        legL.setW(-10);
        legR.setW(10);
        legL.setXY(0,bodyF.getBodyHeight()-1);
        legR.setXY(0,bodyF.getBodyHeight()-1);
        armR.draw();
        armL.draw();
        legR.draw();
        legL.draw();
        bodyF.draw();
        armR.draw();
        setStandardPosition();
        popMatrix();
      }
      else if((t-u)<40){
        pushMatrix();
        translate(0,-15);
        bodyF.setXY(0,0);
        armL.setW(-30);
        armR.setW(30);
        armR.setXY(-bodyF.getWidth()/3,0);
        armL.setXY(bodyF.getWidth()/3,3);
        legL.setW(-30);
        legR.setW(30);
        legL.setXY(-2,bodyF.getBodyHeight()-1);
        legR.setXY(4,bodyF.getBodyHeight()-1);
        armR.draw();
        armL.draw();
        legR.draw();
        legL.draw();
        bodyF.draw();
        armR.draw();
        setStandardPosition();
        popMatrix();
      }
      else if((t-u)<60){
        pushMatrix();
        translate(0,-8);
        bodyF.setXY(0,0);
        armL.setW(0);
        armR.setW(0);
        armR.setXY(-bodyF.getWidth()/3,0);
        armL.setXY(bodyF.getWidth()/3,0);
        legL.setW(-10);
        legR.setW(10);
        legL.setXY(0,bodyF.getBodyHeight()-1);
        legR.setXY(0,bodyF.getBodyHeight()-1);
        armR.draw();
        armL.draw();
        legR.draw();
        legL.draw();
        bodyF.draw();
        armR.draw();
        setStandardPosition();
        popMatrix();
      }
      else{
        setStandardPosition();
        armL.setW(70);
        armL.setXY(bodyF.getWidth()/3+8, 0);
        armL.draw();
        legL.setXY(0, bodyF.getBodyHeight()-1);//40
        legL.draw();
        legR.setXY(0, bodyF.getBodyHeight()-1);
        legR.draw();
        bodyF.setXY(0, 0);
        bodyF.draw();
        armR.setW(-55);
        armR.setXY(-bodyF.getWidth()/3-2, 4);
        armR.draw();
        actionFlag.put("jump", false);//こんな感じ？
        actionFlag.put("stand", true);
        t = 0;
        u = 1000;
      }
    }
  }
}

