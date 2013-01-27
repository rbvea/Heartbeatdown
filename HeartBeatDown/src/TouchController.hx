import flambe.System;
import flambe.input.Touch;
import flambe.input.TouchPoint;
import flambe.input.Key;


class TouchController extends AbstractController
{
  private var tempTrace:flambe.display.TextSprite;

  public function new(game)
  {
    super(game);
    System.touch.down.connect(touchDown);
    System.touch.up.connect(touchUp);
    System.touch.move.connect(touchMove);

    tempTrace = new flambe.display.TextSprite(new flambe.display.Font(HeartBeatDownMain.pack, "redrum72"), "DEBUG");
    game.layer_ui.add(tempTrace);
  }
  private inline function touchDown(point:TouchPoint):Void
  {
    tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
  }
  private inline function touchUp(point:TouchPoint):Void
  {
    tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
  }
  private inline function touchMove(point:TouchPoint):Void
  {
    tempTrace.text = Std.string(point.viewX) + " " + Std.string(point.viewY);
  } 
}