import flambe.Entity;
import flambe.Component;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.swf.MoviePlayer;
import flambe.swf.Library;

class Player
{
	private static inline var PLAYER_Y_POSITION = 650; 
	private static inline var RAIL_SWITCH_SPEED = .25; // seconds

  public var entity:Entity;
  public var pos:Int; // rail id, 1,2,3,4,5,6

  private var game:Game;
  private var body:MoviePlayer;


  public function new(game:Game)
  {
    this.game = game;
    this.pos = 3;
    entity = new Entity()
      .add( new MoviePlayer(new Library(HeartBeatDownMain.pack, "ship")).loop("Parent"))
      .add( new Sprite().setXY(Game.RAIL_POSITIONS[pos-1],PLAYER_Y_POSITION));
            
  }
  public function moveLeft():Void
  {
    if(pos>1){
      pos--;
      entity.get(Sprite).x.animateTo(Game.RAIL_POSITIONS[pos-1], RAIL_SWITCH_SPEED);
    }
  }
  public function moveRight():Void
  {
    if(pos<6){
      pos++;
      entity.get(Sprite).x.animateTo(Game.RAIL_POSITIONS[pos-1], RAIL_SWITCH_SPEED);
	}
  }
}
