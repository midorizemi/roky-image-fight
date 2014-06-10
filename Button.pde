//ボタンクラス
public class Button {
  private int x, y;
  private int wid = 100, hei = 100;
  private final String comand;
  private final color c;
  private boolean life = true;

  public Button(int x, int y, String comand, String colorName) {
    this.comand = comand;
    c = setColors(colorName);
    this.x = x;
    this.y = y;
  }
  
  //ボタンの色の定義ここでボタンの色を増やす
  private color setColors(String s) {
    if (s.equals("red")) return color(255, 0, 0);
    if (s.equals("blue")) return color(0, 0, 255);
    if (s.equals("green")) return color(0, 255, 0);
    if (s.equals("yellow")) return color(255, 255, 0);
    if (s.equals("purple")) return color(255, 0, 255);
    if (s.equals("cian"))return color(0, 255, 255);
    return color(0, 0, 0);
  }

  public void draw() {
    if (life) {
      fill(c);
      rect(x, y, wid, hei);
    }
  }
  
  //ボタンの上に
  public boolean onButton(int mx, int my) {
    if (mx > x && mx < x + wid) {
      if (my > y && my < y + hei) {
        return true;
      }
    }

    return false;
  }
  
  //ボタンを消す
  public void kill() {
    x = -1;
    y = -1;
    wid = 0;
    hei = 1;
    life = false;
  }
}

