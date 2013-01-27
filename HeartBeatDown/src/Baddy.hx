class Baddy implements IHittable 
{

  public var game:Game;

  public function new(game:Game)
  {
    this.game = game;

  }
  public function hit():Void{}

}