import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.System;
import flambe.swf.MoviePlayer;
import flambe.swf.Library;

class Baddy1 extends Baddy
{

	public var entity:Entity;
	private var body:MoviePlayer;
	
	public function new(game:Game)
  {
    super(game);

    entity = new Entity()
		.add(new MoviePlayer(new Library(HeartBeatDownMain.pack, "Bacteria-Simple")).loop("Bacteria"));
		
	var randX = Std.random(204) + 400;
	var randY = Std.random(154) + 307;
	var stage_width = System.stage.width;
	var stage_height  = System.stage.height;
	
	entity.add(new Sprite().setXY(randX, randY).setScale(0.2));

	var body = entity.get(Sprite);

	if(randX <  stage_width / 2) {
		if(randY < stage_width / 2) { // top left
			trace("top left");
			body.anchorX._ = 3 * (System.stage.width / 4);
			body.anchorY._ = 3 * (System.stage.height / 4);
		} else {  // bottom left
			trace("bottom left");
			body.anchorX._ = System.stage.width / 4;
			body.anchorY._ = 3 * (System.stage.height / 4);
		}
	} else {
		if(randY < stage_width / 2) { // top right 
			trace("top right");
			body.anchorX._ = System.stage.width / 4;
			body.anchorY._ = 3 * (System.stage.height / 4);
		} else {  // bottom right
			trace("bottom right");
			body.anchorX._ = System.stage.width / 4;
			body.anchorY._ = System.stage.width / 4;
		}
	}
    body.pointerDown.connect(pointerDown);
    body.pointerUp.connect(pointerUp);

	body.scaleX.animateTo(0.6, 2);
	body.scaleY.animateTo(0.6, 2);

  }
  public override function hit():Void // called by pointerDown
  {
    this.entity.dispose();
  }
}
