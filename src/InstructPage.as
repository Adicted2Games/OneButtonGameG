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
	public class InstructPage extends Music
	{
		private var exit:Boolean = false;
		private var myTimer:Timer;
		private var instr:InstructPage;
		private var music:Music = new Music();
		private const openMenu:String = "startMenu";
		private var background:Background1 = new Background1;
		public function InstructPage() 
		{
			music.playMusic("../bin/bensound-popdance(duringCredits).mp3");
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
					instr = null;
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