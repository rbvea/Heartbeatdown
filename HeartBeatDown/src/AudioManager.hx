import flambe.sound.Playback;
import flambe.swf.Library;


class AudioManager 
{
  private static inline var HEARTBEAT_LOOPS = [
    "audio/hb_060",
    "audio/hb_070",
    "audio/hb_080",
    "audio/hb_090",
    "audio/hb_100",
    "audio/hb_110",
    "audio/hb_120",
    "audio/hb_130",
    "audio/hb_140",
    "audio/hb_150",
    "audio/hb_160",
    "audio/hb_170",
    "audio/hb_180"
    ];

  private var game:Game;

  //private var playbacks : IntHash<Playback>;
  private var playback:Playback;
  private var cur_loop_id:Int;

  public function new(game:Game)
  {
    this.game = game;

    playback = HeartBeatDownMain.pack.getSound(HEARTBEAT_LOOPS[0]).loop();
  }
  public function playHeartBeat(id:Int):Void // 1 - 12
  {
    if(id < HEARTBEAT_LOOPS.length){
      if(id!=cur_loop_id){
        cur_loop_id = id;
        playback.dispose(); // should only do this on end of heartbeat playback
        playback = HeartBeatDownMain.pack.getSound(HEARTBEAT_LOOPS[cur_loop_id]).loop();
        trace("playing heart rate :"+id);
      }
    }else{
      //new flambe.util.Logger().error("there is no heartbeat with id:"+id);
      throw("there is no heartbeat with id:"+id);
    }
  }
}