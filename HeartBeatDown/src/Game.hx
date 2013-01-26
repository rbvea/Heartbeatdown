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
      .add(new ImageSprite(HeartBeatDownMain.pack.getTexture("Artery")));
    layer_walls.addChild(artery);

    // temporary code to test Baddie
    var virus = new Virus(1000);
  }
  override public function onAdded ()
  {
    
  }
}