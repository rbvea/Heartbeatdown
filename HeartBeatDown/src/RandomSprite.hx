import flambe.Entity;
import flambe.Component;
import flambe.display.Sprite;
import flambe.asset.AssetPack;
import flambe.script.Sequence;
import flambe.System;

class RandomSprite extends Component
{
	public var entity: Entity;

	private var height: Float;
	private var width: Float;
    private var _pack :AssetPack;

	function new(arteryRadius :Float)
	{
		var sprite = entity.get(Sprite);
		var spriteWidth = sprite.getNaturalWidth();
		var spriteHeight = sprite.getNaturalHeight();
        sprite.centerAnchor();
        var randomX = (arteryRadius - spriteWidth/2) * Math.random();
        var randomY = Math.sqrt(arteryRadius*arteryRadius - randomX*randomX) - spriteHeight/2;
        sprite.x._ = 2*randomX + System.stage.width/2 - arteryRadius;
        sprite.y._ = 2*randomY + System.stage.height/2 - arteryRadius;
	}
}