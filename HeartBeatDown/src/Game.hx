import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.System;
import flambe.script.Sequence;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Repeat;
import flambe.script.Script;

class Game extends Component 
{
  private static inline var INIT_MOVESPEED = .02; // .05 is pretty fast

	public var layer_bg:Entity;
	public var layer_walls:Entity;
	public var layer_wall:LayerWall;
	public var layer_game:Entity;
	public var layer_player:Entity;
	public var layer_ui:Entity;

  public var artery:Entity;

  public var player:Player;

  public var moveSpeed:Float; // rate that layerWalls are spawned

  private var controller:AbstractController; // for moving left/right
  private var pointer:PointerController;     // for blasting baddies


  private var tick:Int;
  private var forking_action:Bool;
  private var layer_walls_list:List<LayerWall>;

  public function new()
  {
    layer_bg = new Entity();     // end of the tunnel
    layer_walls = new Entity();  // tunnel animations
    layer_game = new Entity();   // baddies and powerups
    layer_player = new Entity(); // main character
    layer_ui = new Entity();     // ui score

    layer_bg.add(new Sprite());
    layer_walls.add(new Sprite());
    layer_game.add(new Sprite());
    layer_player.add(new Sprite());
    layer_ui.add(new Sprite());

    System.root.addChild(layer_bg, true);
    System.root.addChild(layer_walls, true);
    System.root.addChild(layer_game, true);
    System.root.addChild(layer_player, true);
    System.root.addChild(layer_ui, true);

  	//layer_game.addChild(new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft"))));

  	layer_bg.addChild(new BgLayer().entity);

    // temporary code to test Baddie
    //var virus = new Virus(1000);

    tick = 0;
    forking_action = false;
    layer_walls_list = new List<LayerWall>();
	
    moveSpeed = INIT_MOVESPEED;
  	player = new Player(this);
  	layer_player.addChild(player.entity);

    

#if flash
    controller = new KeyboardController(this);
#elseif html
    controller = new TouchController(this);
#end
    pointer = new PointerController(this);

  }



  override public function onUpdate (dt:Float):Void
  {
    tick++;
    if(!forking_action && tick % 30 == 0){ // 60 should be an inverse of moveSpeed
      var lwall = new LayerWall(this);
      layer_walls_list.add(lwall);
      layer_walls.addChild(lwall.entity);
    }

    if(tick == 440){
      var layer_fork = new LayerFork(this);
      layer_walls.addChild(layer_fork.entity);
      forking_action = true;
    }
    if(forking_action && tick==480){
      forking_action = false;
      tick = 0;
      trace(Std.string(layer_walls_list.length));
    }
  

    // increase all layer wall scales
    for(lw in layer_walls_list){
      if(lw.image.scaleX._<5){
        lw.acceleration += (moveSpeed*dt);
        lw.image.setScale(lw.image.scaleX._+lw.acceleration);
      }else{
        lw.entity.dispose();
        //image.dispose();
        layer_walls_list.remove(lw);
      }
    }
    
  }


}

