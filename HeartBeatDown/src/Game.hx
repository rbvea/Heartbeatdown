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
  private static inline var INIT_MOVESPEED = 3.0; // 5.0 is pretty fast
  private static inline var TICKS_PER_MAP_SEGMENT = 480;

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
  public var miniMapLocation:Point;
  public var miniMapUser:ImageSprite;
  public var moveSpeed:Float; // rate that layerWalls are spawned

  private var controller:AbstractController; // for moving left/right
  private var pointer:PointerController;     // for blasting baddies

  // public var layer_wall:LayerWall;
  private var tick:Int;
  private var forking_action:Bool;
  private var layer_walls_list:List<LayerWall>;

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

  	//layer_game.addChild(new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft"))));

    var layer_i = 0;
    var baddy_random = Std.random(TICKS_PER_MAP_SEGMENT);
    layer_walls_list = new List<LayerWall>();


  	layer_bg.addChild(new BgLayer().entity);

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


    currentNode = map.startNode;
    makeMiniMap();

  }

  public function chooseNode(direction:Direction):Void{
    switch (direction) {
      case Direction.LEFT:
        currentNode = currentNode.left;
      case Direction.RIGHT: 
        currentNode = currentNode.right;
    }
    trace(currentNode);
    trace(currentNode.difficulty);
  }

  override public function onUpdate (dt:Float):Void
  {
    var forkTicks = TICKS_PER_MAP_SEGMENT * (currentNode.pointArray.length - 1);
    tick++;
    if(!forking_action && (tick * moveSpeed) % 90 == 0){
      var lwall = new LayerWall(this);
      layer_walls_list.add(lwall);
      layer_walls.addChild(lwall.entity);
    }

    if(tick == forkTicks-40){
      var layer_fork = new LayerFork(this);
      layer_walls.add(layer_fork);
      layer_walls.addChild(layer_fork.entity);
      forking_action = true;
    }
    if(forking_action && tick==forkTicks){
      forking_action = false;
      tick = 0;
      trace(Std.string(layer_walls_list.length));
    }
  

    // increase all layer wall scales
    for(lw in layer_walls_list){
      if(lw.image.scaleX._<5){
        lw.acceleration += (moveSpeed*dt/100);
        lw.image.setScale(lw.image.scaleX._+lw.acceleration);
      }else{
        lw.entity.dispose();
        //image.dispose();
        layer_walls_list.remove(lw);
      }
    }
    
    updateMiniMap();


  }

  private function makeMiniMap(): Void
  {
    miniMap = new Entity()
      .add(new ImageSprite(HeartBeatDownMain.pack.getTexture("mini_map_level1")));
    var sprite = miniMap.get(Sprite);
    var spriteWidth = sprite.getNaturalWidth();
    sprite.x._ = System.stage.width - spriteWidth;
    miniMapLocation = new Point(sprite.x._, sprite.y._);
    miniMapUser = new ImageSprite(HeartBeatDownMain.pack.getTexture("blue_arrow"));
    miniMapUser.centerAnchor();
    miniMapUser.setXY(currentNode.pointArray[0].x + miniMapLocation.x, 
                      currentNode.pointArray[0].y + miniMapLocation.y);
    layer_ui.addChild(miniMap);
    layer_ui.addChild(new Entity().add(miniMapUser));
  }

  private function updateMiniMap(): Void
  {
    trace("tick = " + tick);
    var segment = Std.int(tick / TICKS_PER_MAP_SEGMENT);
    trace("Node = " + currentNode.id);
    trace("segment = " + segment);
    var startPoint = currentNode.pointArray[segment];
    var endPoint = currentNode.pointArray[segment + 1];
    var curX = startPoint.x + (endPoint.x - startPoint.x) * tick / TICKS_PER_MAP_SEGMENT;
    var curY = startPoint.y + (endPoint.y - startPoint.y) * tick / TICKS_PER_MAP_SEGMENT;
    miniMapUser.x._ = curX + miniMapLocation.x;
    miniMapUser.y._ = curY + miniMapLocation.y;
  }

}

