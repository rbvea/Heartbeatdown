import flambe.Component; import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.script.Script;
import flambe.script.Repeat;
import flambe.script.CallFunction;
import flambe.script.Sequence;
import flambe.script.AnimateTo;
import flambe.script.Delay;
import flambe.System;

class LayerFork extends Component{


	//scale to zoom to before you choose to zoom in to a fork
	private static var SCALE:Float = 0.6; 

	private var script:Script;
	private var image1:ImageSprite;
	private var image2:ImageSprite;
	public var entity:Entity;
	private var fork1:Entity;
	private var fork2:Entity;
	private var game:Game;
	private var acceleration:Float; 
	private var activeFork:Bool;
	
	public function new (game:Game)
	{
		this.game = game;
		this.acceleration = 0;
		
		entity = new Entity().add(new Script());

		image1 = new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_tunnels"));
		image1.setXY(System.stage.width / 2, System.stage.height / 2);
		image1.centerAnchor();
		image1.setScale(0.4);
		entity.add(image1);

		image1 = entity.get(ImageSprite);
		activeFork = true;
	}

	override function onUpdate(dt:Float):Void
	{
		acceleration += (game.moveSpeed*dt/100);
		if(image1.scaleX._< 2.8){
			if(game.player.pos > 2) {
				zoomRight();
			} else {
				zoomLeft();
			}
			//image.dispose();
		}else if(activeFork) {
			game.chooseNode( (game.player.pos > 3)? Direction.RIGHT:Direction.LEFT );
			// finished animation.
			entity.dispose();
			activeFork = false;
		}
		image1.setScale(image1.scaleX._+acceleration);
	}
	
	private inline function zoomLeft() {
		if(image1.x._ < System.stage.width*1.5){
			image1.x._ += acceleration*200;
		}
	}

	private inline function zoomRight() {
		if(image1.x._ > -(System.stage.width/2)){
			image1.x._ -= acceleration*200;
		}
	}
 } 
