package  
{
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Music;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Credits extends Music
	{
		private var exit:Boolean = false;
		private var myTimer:Timer;
		private var cred:Credits;
		private var music:Music = new Music();
		private const openMenu:String = "startMenu";
		private var background:Background2 = new Background2;
		public function Credits() 
		{
			music.playMusic("../bin/bensound-happyrock(duringCredits).mp3");
			addChild(background);
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function init(e:Event):void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE )
			{
				if (exit == true) 
				{
					dispatchEvent(new Event (openMenu, true));
					removeEventListener(Event.ADDED_TO_STAGE, init);
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					music.stop();
					parent.removeChild(this);
					cred = null;
					trace("test");
				}
			}
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE )
			{
				exit = true;
			}
		}
	}
}