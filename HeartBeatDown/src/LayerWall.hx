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

class LayerWall extends Component {

	//speed in seconds of the zooming nimation
	private static var SPEED:Int = 2;

	private var game:Game;
	private var script:Script;
	
	public var entity:Entity;
	public var image:ImageSprite;
	public var acceleration:Float;
	
	
	public function new (game:Game)
	{
		this.game = game;
		this.acceleration = 0.01;
		entity = new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft")));

		image = entity.get(ImageSprite);
		image.setScale(0);
		image.setXY(System.stage.width / 2, System.stage.height / 2).setScale(0.2).centerAnchor();
		
	}
}
