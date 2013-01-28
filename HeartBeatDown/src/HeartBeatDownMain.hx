import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.System;
import flambe.display.ImageSprite;
import flambe.input.PointerEvent;

class HeartBeatDownMain
{
  public static var pack :AssetPack;

  private static var title_screen:ImageSprite;
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
	
	public static function cleanup() {
		System.root.disposeChildren();
	}
}
