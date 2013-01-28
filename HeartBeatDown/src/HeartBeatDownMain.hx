import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.System;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.input.PointerEvent;

class HeartBeatDownMain
{
  public static var pack :AssetPack;

  private static var title_screen:ImageSprite;
  private static var gameover_screen:Entity;

    private static function onSuccess (pack :AssetPack)
    {
        HeartBeatDownMain.pack = pack;
        // load title screen
        title_screen = new ImageSprite(pack.getTexture("ui/ui_title_screen"));
        title_screen.pointerUp.connect(start_game);
        System.root.add(title_screen);
    }
    private static inline function start_game(event:PointerEvent):Void{
        System.root.remove(title_screen);
        System.root.add(new Game());
    }

    private static function main ()
    {
        // Wind up all platform-specific stuff
        System.init();

        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.build("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }
	
	public static function gameOver() {
        // cleanup
		System.root.disposeChildren();

        // show game over screen
        gameover_screen = new Entity();
        var bg = new Entity()
            .add(new ImageSprite(pack.getTexture("ui/ui_background")));
        //var success = new Entity()
        //    .add(new ImageSprite(pack.getTexture("ui/ui_success")));
        gameover_screen.addChild(bg);
        //gameover_screen.addChild(success);

        var credits = new Entity().add( new ImageSprite(pack.getTexture("ui/ui_credits")));
        gameover_screen.addChild(credits);
        credits.get(ImageSprite).setXY(System.stage.width/2, System.stage.height/2).centerAnchor();
        
        System.root.addChild(gameover_screen);
	}
}
