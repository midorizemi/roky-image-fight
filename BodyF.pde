public class BodyF extends Parts {
  private static final float range = 0.3;
  
  public BodyF(){
    super("bodyF.png");
    super.setImgXY(-getWidth()/2+2,-getHeadHeight());
  }
  
  int getBodyHeight(){
    return (int)((1 - range) * getHeight());
  }
  
  int getHeadHeight(){
    return (int) (range * getHeight());
  }
}
