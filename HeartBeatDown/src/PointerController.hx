import flambe.System;
import flambe.input.Pointer;
import flambe.input.PointerEvent;


class PointerController extends AbstractController
{
  private var tempTrace:flambe.display.TextSprite;

  private var touching:Bool;

  public function new(game)
  {
    super(game);
    
    touching = false;

    System.pointer.down.connect(touchDown);
  }

  private inline function touchDown(point:PointerEvent):Void
  {
    if(!touching){
      var touched = point.hit;
      // trace(touched);
      // if(touched != null){
      //   touched.hit();
      // }
      touching = true;
    }
  }
  private inline function touchUp(point:PointerEvent):Void
  {
    touching = false;
  }

}