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

  public function new()
  {
    layer_bg = new Entity();
    layer_walls = new Entity(); 
    layer_game = new Entity();
    layer_player = new Entity();
    layer_ui = new Entity();

    layer_bg.add(new Sprite());
    layer_game.add(new Sprite());
    layer_player.add(new Sprite());
    layer_ui.add(new Sprite());

    System.root.addChild(layer_bg, true);
    System.root.addChild(layer_walls, true);
    System.root.addChild(layer_game, true);
    System.root.addChild(layer_player, true);
    System.root.addChild(layer_ui, true);

	//layer_game.addChild(new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft"))));

	layer_walls.add(new Script());
	/*
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
		]));*/

	layer_bg.addChild(new BgLayer().entity);
	layer_walls.addChild(new LayerFork().entity);

    // temporary code to test Baddie
    //var virus = new Virus(1000);
  }



  override public function onAdded ()
  {
    
  }
}
