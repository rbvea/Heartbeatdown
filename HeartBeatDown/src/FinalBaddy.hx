import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.System;
import flambe.swf.MoviePlayer;
import flambe.swf.Library;
import flambe.swf.MovieSprite;

class FinalBaddy extends Baddy
{

	public var entity:Entity;
	private var body:MovieSprite;
	
	public function new(game:Game)
  {
    super(game);

    var moviePlayer = new MoviePlayer(new Library(HeartBeatDownMain.pack, "Bacteria-Simple")).loop("Bacteria");
    entity = new Entity().add(moviePlayer);
		
    var stage_height  = System.stage.height;
    var stage_width  = System.stage.width;

    var randX = Std.random(Std.int(stage_width*.1))-(stage_width*.05);
    var randY = Std.random(Std.int(stage_height*.1))-(stage_height*.05);

    body = moviePlayer.movie;
    body.setXY(randX+(stage_width/2),randY+(stage_height/2)).setScale(0.0);

    if(randX < 0) {
    	if(randY < 0) { // top left
			body.anchorX.animateTo((stage_width/6) + (randX * 10), 4-game.currentNode.difficulty); // *(randX*100)
			body.anchorY.animateTo((stage_height/6) + (randY * 10) , 4-game.currentNode.difficulty);
    	} else {  // bottom left
        body.anchorX.animateTo((stage_width/6) + (randX * 10) , 4-game.currentNode.difficulty);
        body.anchorY.animateTo(-(stage_height/6) + (randY * 10), 4-game.currentNode.difficulty); // fine tuning negative * 2 ?
    	}
    } else { // randX > stage_width/2
    	if(randY < 0) { // top right 
			body.anchorX.animateTo(-(stage_width/6) + (randX * 10), 4-game.currentNode.difficulty);
        body.anchorY.animateTo((stage_height/6) + (randY * 10), 4-game.currentNode.difficulty);
    	} else {  // bottom right
			body.anchorX.animateTo(-(stage_width/6) +  (randX * 10) , 4-game.currentNode.difficulty);
			body.anchorY.animateTo(-(stage_height/6) + (randY * 10), 4-game.currentNode.difficulty);
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
