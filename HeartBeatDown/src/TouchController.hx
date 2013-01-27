import flambe.System;
import flambe.input.Pointer;
import flambe.input.PointerEvent;
import flambe.input.Key;


class TouchController extends AbstractController
{
  private var touching:Bool;
  private var downX: Float;
  inline private static var swipeMinDistance = 200;

  public function new(game)
  {
    super(game);
    
    touching = false;

    System.pointer.down.connect(touchDown);
    System.pointer.up.connect(touchUp);
    // System.pointer.move.connect(touchMove);
    
  }

  private inline function touchDown(point:PointerEvent):Void
  {
    downX = point.viewX;
    touching = true;
  }
  private inline function touchUp(point:PointerEvent):Void
  {
    if(point.viewX > downX + swipeMinDistance) {
      goLeft();
    } else if (point.viewX < downX - swipeMinDistance) {
      goRight();
    }
    touching = false;
  }
  // private inline function touchMove(point:PointerEvent):Void
  // {
    
  // }

}