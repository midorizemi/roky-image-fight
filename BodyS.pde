public class BodyS extends Parts {
  private static final float range = 0.3;
  
  public BodyS(){
    super("bodyS.png");
    super.setImgXY(-this.getWidth()/2+1,-getHeadHeight());
  }
  
  int getBodyHeight(){
    return (int)((1 - range) * getHeight());
  }
  
  int getHeadHeight(){
    return (int) (range * getHeight());
  }
}
