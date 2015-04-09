package  {

    import flash.display.*; 
    import flash.events.Event; 
    import flash.net.*; 
    import flash.media.*; 

    public class Music extends Sprite {
		
		public var track:String = "../music/bensound-moose(duringMenu).mp3";
        private var music:Sound;
        private var request:URLRequest;
		public var track2:String;
        private var buffer:SoundLoaderContext;
        private var channel:SoundChannel;
        public function Music() {
			
        }
		
        public function playMusic(track:String):void
        {
			
			
			buffer = new SoundLoaderContext(1000);
            request = new URLRequest(track);
            music = new Sound(request, buffer);
            channel = music.play(0,99999);
			
			
            //channel.addEventListener(Event.SOUND_COMPLETE);
        }
		public function stop():void
		{
			channel.stop();
		}
    }
}