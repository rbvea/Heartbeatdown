class AbstractController 
{
  private var game:Game;

  public function new(game)
  {
    this.game = game;
  }

  public dynamic function goLeft():Void // swipe or push left key
  {
    game.player.moveLeft();
  }

  public dynamic function goRight():Void // swipe or push right key
  {
    game.player.moveRight();
  }

}