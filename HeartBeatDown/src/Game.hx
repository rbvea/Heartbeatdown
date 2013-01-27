import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.System;
import flambe.script.Sequence;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;

class Game extends Component 
{

	public var layer_bg:Entity;
	public var layer_walls:Entity;
	public var layer_wall:LayerWall;
	public var layer_game:Entity;
	public var layer_player:Entity;
	public var layer_ui:Entity;

  public var artery:Entity;

  public var player:Player;

  private var controller:AbstractController;

  public function new()
  {
    layer_bg = new Entity();     // end of the tunnel
    layer_walls = new Entity();  // tunnel animations
    layer_game = new Entity();   // baddies and powerups
    layer_player = new Entity(); // main character
    layer_ui = new Entity();     // ui score

    layer_bg.add(new Sprite());
    layer_walls.add(new Script());
    layer_game.add(new Sprite());
    layer_player.add(new Sprite());
    layer_ui.add(new Sprite());

    System.root.addChild(layer_bg);
    System.root.addChild(layer_walls);
    System.root.addChild(layer_game);
    System.root.addChild(layer_player);
    System.root.addChild(layer_ui);


    // ui
  	layer_game.addChild(new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft"))));

    // layer_walls
  	layer_walls.get(Script).run(new Sequence([
  		new CallFunction(function() {
  			layer_wall = new LayerWall();
  			layer_walls.addChild(layer_wall.entity);
  		}),
  		new Delay(1),
  		new CallFunction(function() {
  			layer_wall = new LayerWall();
  			layer_walls.addChild(layer_wall.entity);
  		}),
  	]));
    
    layer_bg.addChild(new BgLayer().entity);

    // temporary code to test Baddie
    //var virus = new Virus(1000);
	
	
	
	player = new Player(this);
	layer_player.addChild(player.entity);

	#if flash
	    controller = new KeyboardController(this);
	#elseif html
	    controller = new TouchController(this);
	#end
	
  }



  override public function onAdded ()
  {
    
  }


  public function doMoveLeft():Void
  {
    player.moveLeft();
  }
  public function doMoveRight():Void
  {
    player.moveRight();
  }

}

