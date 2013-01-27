import flambe.Entity;
import flambe.display.ImageSprite;

class Baddy1 extends Baddy
{

  public var entity:Entity;
  
  private var body:ImageSprite;

  public function new(game:Game)
  {
    super(game);

    entity = new Entity();
    body = new ImageSprite(HeartBeatDownMain.pack.getTexture("bacteria"));
    entity.add(body);

    body.setXY(Std.random(1000), Std.random(500));
  }
  public override function hit():Void
  {
    trace("dispose entity");
    this.entity.dispose();
  }
}