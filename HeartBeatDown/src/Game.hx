import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.System;
import flambe.script.Sequence;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Repeat;
import flambe.script.Script;
import haxe.FastList;

class Game extends Component 
{
  private static inline var INIT_MOVESPEED = .03; // .05 is pretty fast
  private static inline var BADDY_SPAWN_RATE_DIFFICULTY = [80,55,25]; // 0 = EASY

	public var layer_bg:Entity;
	public var layer_walls:Entity;
	public var layer_game:Entity;
	public var layer_player:Entity;
	public var layer_ui:Entity;

	public var artery:Entity;
	public var player:Player;
  public var currentNode:Branch;
  public var map:Map;
  public var miniMap:Entity;
  public var moveSpeed:Float; // rate that layerWalls are spawned

  private var controller:AbstractController; // for moving left/right
  private var pointer:PointerController;     // for blasting baddies
  private var audioManager:AudioManager;
  
  // public var layer_wall:LayerWall;
  private var tick:Int;
  private var forking_action:Bool;
  private var baddies:FastList<Baddy>;
  private var layer_walls_list:FastList<LayerWall>;
  private var baddy_spawn_rate:Int;
  private var heart_rate:Int; // 0-11
	private var reachedEnd:Bool;
	private var baddy_random:Int; 

  public function new()
  {
    this.map = new Map();

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

    miniMap = makeMiniMap();
    layer_ui.addChild(miniMap);

	baddy_random = Std.random(480);
    forking_action = false;
    layer_walls_list = new haxe.FastList<LayerWall>();
  	layer_bg.addChild(new BgLayer().entity);

    tick = 0;
    heart_rate = 0;
    forking_action = false;
    baddies = new haxe.FastList<Baddy>();
	
    moveSpeed = INIT_MOVESPEED;
  	player = new Player(this);
  	layer_player.addChild(player.entity);

#if flash
    controller = new KeyboardController(this);
#elseif html
    controller = new TouchController(this);
#end
    pointer = new PointerController(this);
    audioManager = new AudioManager(this);

    currentNode = map.startNode;
    baddy_spawn_rate = BADDY_SPAWN_RATE_DIFFICULTY[currentNode.difficulty-1]; // * difficulty
  }

  public function chooseNode(direction:Direction):Void{
    switch (direction) {
      case Direction.LEFT:
		  if(currentNode.left != null) {
			  currentNode = currentNode.left;
		  } else {
			  reachedEnd = true;
			  tick = 0;
		  }
      case Direction.RIGHT: 
		  if(currentNode.right != null) {
			  currentNode = currentNode.right;
		  } else {
			  reachedEnd = true;
			  tick = 0;
		  }
    }
    
    // increase heart rate faster and faster as we get closer, and more if more difficult
    // temporary math is here.
    heart_rate += currentNode.difficulty;
    if(heart_rate > 11) heart_rate = 11;
    else if(heart_rate < 0) heart_rate = 0;
    
    audioManager.playHeartBeat(heart_rate);

  }

  override public function onUpdate (dt:Float):Void
  {
	  tick++;
	if(!reachedEnd) {
		if(!forking_action && tick % 30 == 0){ // 60 should be an inverse of moveSpeed
			var lwall = new LayerWall(this);
			layer_walls_list.add(lwall);
			layer_walls.addChild(lwall.entity);
		}

		if(tick == 440){
			var layer_fork = new LayerFork(this);
			layer_walls.add(layer_fork);
			layer_walls.addChild(layer_fork.entity);
			forking_action = true;
		}

		if(forking_action && tick==480){
			forking_action = false;
			tick = 0;
		}

		if(tick == baddy_random && !forking_action) {
			layer_game.addChild(new Baddy1(this).entity);
			baddy_random = Std.random(480);
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

	} else if(tick < 500) { //rapid spawning baddies
		if(Std.random(5) == 0) {
			layer_game.addChild(new FinalBaddy(this).entity);
		}
	} else { //fadeOut
			var final = new Entity().add(
				new FillSprite(0xFFFFFF, System.stage.width, System.stage.height)
			);
			var whiteout = final.get(FillSprite);
			whiteout.alpha._ = 0;
			System.root.addChild(final);
			whiteout.alpha.animateTo(1, 7);
			haxe.Timer.delay(HeartBeatDownMain.cleanup, 7000);
	}
  }
  private function makeMiniMap(): Entity
  {
    var entity = new Entity()
      .add(new ImageSprite(HeartBeatDownMain.pack.getTexture("mini_map_level1")));
    var sprite = entity.get(Sprite);
    var spriteWidth = sprite.getNaturalWidth();
    //sprite.centerAnchor();
    sprite.x._ = System.stage.width - spriteWidth;
    return entity;
  }


}

