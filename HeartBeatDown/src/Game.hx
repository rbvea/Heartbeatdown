import flambe.Entity;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.System;


class Game extends Component 
{

  public var layer_bg:Entity;
  public var layer_walls:Entity;
  public var layer_game:Entity;
  public var layer_player:Entity;
  public var layer_ui:Entity;

  public var artery:Entity;

  public var player:Player;

  public function new()
  {
    layer_bg = new Entity();
    layer_walls = new Entity();
    layer_game = new Entity();
    layer_player = new Entity();
    layer_ui = new Entity();

    layer_bg.add(new Sprite());
    layer_walls.add(new Sprite());
    layer_game.add(new Sprite());
    layer_player.add(new Sprite());
    layer_ui.add(new Sprite());

    System.root.addChild(layer_bg);
    System.root.addChild(layer_walls);
    System.root.addChild(layer_game);
    System.root.addChild(layer_player);
    System.root.addChild(layer_ui);

    var artery = new Entity()
      .add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery")));
    layer_walls.addChild(artery);

    player = new Player(this);
    layer_player.addChild(player.entity);
  }
  override public function onAdded ()
  {
    
  }
}