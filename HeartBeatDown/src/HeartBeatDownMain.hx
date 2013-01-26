import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.System;

class HeartBeatDownMain
{
  public static var pack :AssetPack;

    private static function onSuccess (pack :AssetPack)
    {
        HeartBeatDownMain.pack = pack;
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
}
