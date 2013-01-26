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
        game.doMoveRight();
      case Key.Left:
        game.doMoveLeft();
      default:
        // nothing
    }
  }
}