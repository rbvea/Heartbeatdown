import flambe.System;
import flambe.input.KeyboardEvent;
import flambe.input.Key;

class KeyboardController extends AbstractController
{
  public function new(game)
  {
    super(game);
    System.keyboard.up.connect(keyUp);
  }
  private function keyUp(event:KeyboardEvent):Void
  {
    switch (event.key) {
      case Key.Right:
        goRight();
      case Key.Left:
        goLeft();
      default:
        // nothing
    }
  }
}