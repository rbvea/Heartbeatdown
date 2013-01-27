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
	private var map:Map;
	
	public function new (game:Game)
	{
		this.game = game;
		this.acceleration = 0;
		this.map = new Map();

		entity = new Entity().add(new Script());
		fork1 = new Entity();
		fork2 = new Entity();

		image1 = new ImageSprite(HeartBeatDownMain.pack.getTexture("fork_artery_draft"));
		image1.setXY(System.stage.width / 2, System.stage.height / 2);
		image1.setAnchor(image1.getNaturalWidth(), image1.getNaturalHeight()/2);
		image1.setScale(0.05);
		fork1.add(image1);

		image2 = new ImageSprite(HeartBeatDownMain.pack.getTexture("fork_artery_draft"));
		image2.setXY(System.stage.width / 2, System.stage.height / 2);
		image2.setAnchor(0, image2.getNaturalHeight()/2);
		image2.setScale(0.05);
		fork2.add(image2);

		entity.addChild(fork1,true);
		entity.addChild(fork2,true);
		
		image1 = fork1.get(ImageSprite);
		image2 = fork2.get(ImageSprite);
		
		var currentNode = map.startNode;

		while(true) {
			trace("in while loop");
			switch(currentNode) {
				case Branch(difficulty, right, left, pointArray) : {
					entity.get(Script).run(new Sequence([
						new CallFunction(zoomIn),
						new Delay(SPEED*pointArray.length),
						//switch animations based on user input
						new CallFunction(function() {
							if(game.player.pos > 3) {
								currentNode = right;
								trace("going right");
								zoomRight();
							} else {
								currentNode = left;
								trace("going left");
								zoomLeft();
							}
						}),
					]));
				}
				case Leaf: {
					break;
					// end of game!
				}
			}
		}

	}

	override function onUpdate(dt:Float):Void
	{
		if(image1.scaleX._<SCALE){
        acceleration += (game.moveSpeed*dt);
        
    }else if(image1.scaleX._<3){
			if(game.player.pos > 3) {
				zoomRight();
			} else {
				zoomLeft();
			}
      //image.dispose();
    }else{
    	entity.dispose();
    }
    image1.setScale(image1.scaleX._+acceleration);
    image2.setScale(image2.scaleX._+acceleration);
	}
	
	private inline function zoomLeft() {
		if(image1.x._ < System.stage.width*1.5){
			image1.x._ += acceleration*500;
			image2.x._ += acceleration*500;
		}
	}

	private inline function zoomRight() {
		if(image2.x._ > -(System.stage.width/2)){
			image1.x._ -= acceleration*500;
			image2.x._ -= acceleration*500;
		}
	}
 } 
