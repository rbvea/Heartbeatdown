import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;

class Player
{
  private static inline var RAIL_POSITIONS = [100,200,300,400,500];
  private static inline var PLAYER_Y_POSITION = 600;


  public var entity:Entity;
  public var pos:Int; // rail id, 1,2,3,4,5

  private var game:Game;
  private var body:ImageSprite;


  public function new(game:Game)
  {
    this.game = game;
    this.pos = 3;
    
    entity = new Entity();
    body = new ImageSprite(HeartBeatDownMain.pack.getTexture("bacteria"));
    entity.add(body);

    body.setXY(RAIL_POSITIONS[pos-1],PLAYER_Y_POSITION);

  }
  public function moveLeft():Void
  {
    if(pos>0){
      pos--;
      body.x.animateTo(RAIL_POSITIONS[pos-1],PLAYER_Y_POSITION);
    }
  }
  public function moveRight():Void
  {
    if(pos<4){
      pos++;
      body.x.animateTo(RAIL_POSITIONS[pos-1],PLAYER_Y_POSITION);
    }
  }
}