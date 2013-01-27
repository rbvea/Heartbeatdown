import flambe.display.FillSprite;
import flambe.Component;
import flambe.System;
import flambe.Entity;
import flambe.display.Sprite;
import flambe.script.Script;
import flambe.script.Repeat;
import flambe.script.CallFunction;

class BgLayer extends Component {

	private var image:FillSprite;
	public var entity:Entity;
	
	public function new () 
	{
		entity = new Entity().add(new FillSprite(0x570000, System.stage.width, System.stage.height));
	}
}
