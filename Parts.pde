//パーツクラス
//赤背景を透過処理して描画する．
public class Parts {
  int x = 0, y = 0;
  int imgX, imgY;
  float w = 0;
  PImage src;
  PImage img;

  public Parts(String s) {
    src = loadImage(s);
    img = createImage(src.width, src.height, ARGB);
  }

  void setXY(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void setImgXY(int srcX, int srcY) {
    this.imgX = srcX;
    this.imgY = srcY;
  }

  void setX(int x) {
    this.x = x;
  }

  void setY(int y) {
    this.y = y;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }

  void setW(float w) {
    this.w = w;
  }

  float getW() {
    return w;
  }

  int getWidth() {
    return src.width;
  }

  int getHeight() {
    return src.height;
  }

  void initialize() {
    setX(0);
    setY(0);
    setW(0);
  }
  
  //透過して描画する
  void draw() {
    //取り込んだ元画像のすべての画素を参照
    for (int j = 0; j < src.height ; j++) {
      for (int i = 0; i < src.width ; i++) {
        int p = j * src.width + i;//ある位置の画素
        float r = .0, g = .0, b = .0;//画素の色数値の初期化

        r = red(src.pixels[p]);//画素pの赤色値
        g = green(src.pixels[p]);//画素pの緑色値
        b = blue(src.pixels[p]);//画素pの青色値

        if (r == 255 && g == 0 && b == 0) {
          img.pixels[p] = color(0, 0, 0, 0);//#FF0000ならば透過
        }
        else {
          img.pixels[p] = color(r, g, b, 255);//画像の色情報を設定
        }
      }
    }
    img.updatePixels();//設定したピクセル値に更新
    
    imageMode(CORNER);
    pushMatrix();
    translate(x, y);
    rotate(radians(w));
    image(img, imgX, imgY);
    popMatrix();
  }
}

