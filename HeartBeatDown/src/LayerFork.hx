import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.script.Script;
import flambe.script.Repeat;
import flambe.script.CallFunction;
import flambe.script.Sequence;
import flambe.script.AnimateTo;
import flambe.script.Delay;
import flambe.System;

class LayerFork extends Component {

	//speed in seconds of the zooming nimation
	private static var SPEED:Float = 2;
	//scale to zoom to before you choose to zoom in to a fork
	private static var SCALE:Float = 0.6;

	private var script:Script;
	private var image1:ImageSprite;
	private var image2:ImageSprite;
	public var entity:Entity;
	private var fork1:Entity;
	private var fork2:Entity;
	private var game:Game;
	
	public function new (game:Game)
	{
		this.game = game;

		entity = new Entity().add(new Script());
		fork1 = new Entity();
		fork2 = new Entity();

		fork1.add(new ImageSprite(HeartBeatDownMain.pack.getTexture("fork_artery_draft")).setXY(System.stage.width / 4, System.stage.height / 2).setScale(0.2).centerAnchor());
		fork2.add(new ImageSprite(HeartBeatDownMain.pack.getTexture("fork_artery_draft")).setXY(3* (System.stage.width / 4), System.stage.height / 2).setScale(0.2).centerAnchor());
		
		entity.addChild(fork1,true);
		entity.addChild(fork2,true);
		
		image1 = fork1.get(ImageSprite);
		image2 = fork2.get(ImageSprite);
		
		entity.get(Script).run(new Sequence([
			new CallFunction(zoomIn),
			new Delay(SPEED),
			//switch animations based on user input
			new CallFunction(function() {
				if(game.player.pos > 2) {
					zoomRight();
				} else {
					zoomLeft();
				}
			}),
		]));
	}

	public function zoomIn() {
		image1.scaleX.animateTo(0.6, SPEED);
		image1.scaleY.animateTo(0.6, SPEED);

		image2.scaleX.animateTo(0.6, SPEED);
		image2.scaleY.animateTo(0.6, SPEED);

	}
	
	public function zoomLeft() {
		image1.x.animateTo(System.stage.width / 2, 1);
		image1.scaleX.animateTo(2, SPEED);
		image1.scaleY.animateTo(2, SPEED);

		image2.x.animateTo(System.stage.width * 2, 1);
		image2.scaleX.animateTo(2, SPEED);
		image2.scaleY.animateTo(2, SPEED);
	}

	public function zoomRight() {
		image1.x.animateTo(-(System.stage.width * 2), 1);
		image1.scaleX.animateTo(2, SPEED);
		image1.scaleY.animateTo(2, SPEED);

		image2.x.animateTo(System.stage.width / 2, 1);
		image2.scaleX.animateTo(2, SPEED);
		image2.scaleY.animateTo(2, SPEED);
	}
 } 
