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

	public var layer_bg:Entity;
	public var layer_walls:Entity;
	public var layer_wall:LayerWall;
	public var layer_game:Entity;
	public var layer_player:Entity;
	public var layer_ui:Entity;

	public var artery:Entity;
	public var player:Player;

	private var controller:AbstractController; // for moving left/right
	private var pointer:PointerController;     // for blasting baddies

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

    var layer_i = 0;
	var baddy_random = Std.random(480);
    var forking_action = false;
    var layer_walls_list = new haxe.FastList<LayerWall>();
  	layer_walls.add(new Script());
  	layer_walls.get(Script).run(
      new Repeat(
        new CallFunction(function() {
          layer_i++;
		  
          if(!forking_action && layer_i % 40 == 0){
            var lwall = new LayerWall();
            layer_walls_list.add(lwall);
            layer_walls.addChild(lwall.entity);
          }

		  if(layer_i == baddy_random) {
			  layer_game.addChild(new Baddy1(this).entity);
			  baddy_random = Std.random(480);
		  }

          if(layer_i == 440){
            var layer_fork = new LayerFork(this);
            layer_walls.addChild(layer_fork.entity);
            forking_action = true;
          }
          if(forking_action && layer_i==480){
            forking_action = false;
            layer_i = 0;
          }
        })
      )
    );

  	layer_bg.addChild(new BgLayer().entity);

	
  	player = new Player(this);
  	layer_player.addChild(player.entity);


#if flash
    controller = new KeyboardController(this);
#elseif html
    controller = new TouchController(this);
#end
    pointer = new PointerController(this);

  }



  override public function onAdded ()
  {
    
  }


}

