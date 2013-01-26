import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.System;


class Game extends Component 
{
  public function new()
  {
    

  }
  override public function onAdded ()
  {
    var artery = new Entity()
      .add(new ImageSprite(HeartBeatDownMain.pack.getTexture("Artery")));
    System.root.addChild(artery);
  }
}