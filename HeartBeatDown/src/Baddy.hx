import flambe.input.PointerEvent;

class Baddy implements IHittable 
{

  public var game:Game;

  public function new(game:Game)
  {
    this.game = game;

  }
  public function hit():Void{}
  private function pointerDown(event:PointerEvent):Void
  {
    this.hit();
  }
  private function pointerUp(event:PointerEvent):Void 
  {
    
  }
}