import flambe.System;
import flambe.input.Pointer;
import flambe.input.PointerEvent;
import flambe.input.Key;


class TouchController extends AbstractController
{
  private var tempTrace:flambe.display.TextSprite;

  private var touching:Bool;
  private var downX: Float;
  inline private static var swipeMinDistance = 200;

  public function new(game)
  {
    super(game);
    
    touching = false;

    System.pointer.down.connect(touchDown);
    System.pointer.up.connect(touchUp);
    System.pointer.move.connect(touchMove);
    
    tempTrace = new flambe.display.TextSprite(new flambe.display.Font(HeartBeatDownMain.pack, "redrum72"), "DEBUG");
    game.layer_ui.add(tempTrace);
  }

  // on swipe left, do  goLeft()
  

  private inline function touchDown(point:PointerEvent):Void
  {
    tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
    downX = point.viewX;
    touching = true;
  }
  private inline function touchUp(point:PointerEvent):Void
  {
    tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
    if(point.viewX > downX + swipeMinDistance) {
      tempTrace.text = "SWIPED LEFT";
      game.player.moveLeft();
    } else if (point.viewX < downX - swipeMinDistance) {
      tempTrace.text = "SWIPED RIGHT";
      game.player.moveRight();
    } else {
      tempTrace.text = "NO SWIPE";
    }
    touching = false;
  }
  private inline function touchMove(point:PointerEvent):Void
  {
    if(touching){
      tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
    } 
  }

}
