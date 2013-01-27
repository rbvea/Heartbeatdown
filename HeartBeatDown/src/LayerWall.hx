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

	private var image:ImageSprite;
	private var script:Script;
	public var entity:Entity;
	
	public function new ()
	{
		entity = new Entity().add(new ImageSprite(HeartBeatDownMain.pack.getTexture("artery_draft")));

		var image = entity.get(ImageSprite);
		image.setScale(0.1);
		image.setXY(System.stage.width / 2, System.stage.height / 2).setScale(0.2).centerAnchor();
		entity.add(new Script());
		entity.get(Script).run(
			new Repeat(
				new CallFunction(function() {
					if(image.scaleX._<5){
						image.setScale(image.scaleX._+.01);
					}else{
						image.dispose();
					}
				})
			)
		);
		/*
		entity.get(Script).run(new Repeat(new Sequence([
			new CallFunction(function() {
				image.scaleX.animateTo(2, SPEED);
				image.scaleY.animateTo(2, SPEED);
			}),
			new CallFunction(function() {
				image.setScale(0.1);
			}),
		])));
*/
	}
}
