import flambe.System;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.script.Sequence;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.CallFunction;

class Hazard 
{

  public var entity:Entity;

  private var game:Game;
  private var body:ImageSprite;

  public function new(game:Game)
  {
    this.game = game;
    body = new ImageSprite(HeartBeatDownMain.pack.getTexture("virus"));
    entity = new Entity().add(body);

    var stage_width = System.stage.width;
    var stage_height  = System.stage.height;

    var randX = Std.random(6);
    body.setXY((stage_width/2),(stage_height/2)).setScale(0.1);

    body.x.animateTo(Game.HAZARD_DESTINATIONS[randX], 4-game.currentNode.difficulty); // 0.6
    body.y.animateTo(stage_height, 4-game.currentNode.difficulty);

    body.scaleX.animateTo(2, 4-game.currentNode.difficulty); // 0.6
    body.scaleY.animateTo(2, 4-game.currentNode.difficulty);

    var script = new Script();
    script.run(new Sequence([
      new Delay((4-game.currentNode.difficulty)-1),
      new CallFunction(function(){
        //trace((randX+1)+" - "+game.player.pos);
        if(randX+1 == game.player.pos){
          trace("got hit");
          game.heart_rate++;
        }
      })
    ]));
    entity.add(script);

  }
}