import flambe.Entity;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.System;

class Bacteria extends Baddie
{

		public function new(arteryRadius :Float)
	{
		height = 200;
		width = 200;
		entity = new Entity()
			.add(new ImageSprite(HeartBeatDownMain.pack.getTexture("Bacteria")));
		super(arteryRadius);
	}
}