class AbstractController 
{
  private var game:Game;

  public function new(game)
  {
    this.game = game;
  }

  public dynamic function goLeft():Void // swipe or push left key
  {
    game.doMoveLeft();
  }

  public dynamic function pressRight():Void // swipe or push right key
  {
    game.doMoveRight();
  }

}