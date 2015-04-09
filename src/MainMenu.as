package  
{
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	//import flash.net.drm.DRMPlaybackTimeWindow;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Music;
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class MainMenu extends Music
	{
		//de knoppen en bars moeten handiger kunnen.
		private var btn1:BtnStart;
		private var btn1_1:BtnStart2;
		private var btn2:BtnStart;
		private var btn2_1:BtnStart2;
		private var btn3:BtnStart;
		private var btn3_1:BtnStart2;
		private var bar1sc:Number = 0;
		private var bar2sc:Number = 0;
		private var bar3sc:Number = 0;
		
		// :(
		private var background:Background = new Background;
		private const openGame:String = "startGame";
		private const openCredits:String = "startCredits";
		private const openInstruct:String = "startInstruct";
		private var counter:int = 0;
		private var counter2:Number = 0;
		private const maxCounter:Number = 3000;
		private var released:Boolean = true;
		private var myTimer:Timer;
		private var music:Music = new Music();
		private var bar1:Shape = new Shape();
		private var bar2:Shape = new Shape();
		private var bar3:Shape = new Shape();
		public function MainMenu()
		{
			addChild(background);
			//background.backgroundLoad("../img/mainMenu.png");
			music.playMusic("../bin/bensound-moose(duringMenu).mp3");
			myTimer = new Timer(15 , 200);
			myTimer.addEventListener(TimerEvent.TIMER, updateTime);
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
 		
		private function endTimer(e:TimerEvent):void
		{
			if (bar1sc >= 1)
			{
				music.stop();
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event (openGame));
				
			}
			if (bar2sc >= 1)
			{
				music.stop();
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event (openInstruct));
			}
			if (bar3sc >= 1)
			{
				music.stop();
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				removeEventListener(Event.ADDED_TO_STAGE, init);
				dispatchEvent(new Event (openCredits));
			}
		}
		
		private function updateTime(e:TimerEvent):void
		{
			
			if (counter == 1)
			{
				bar3sc = 0;
				counter2 += 15;
				bar1sc = (counter2 / maxCounter);
				ajustBars();
			}
			if (counter == 2)
			{
				bar1sc = 0;
				counter2 += 15;
				bar2sc = (counter2 / maxCounter);
				ajustBars()
				
			}
			if (counter == 3)
			{
				bar2sc = 0;
				counter2 += 15 ;
				bar3sc = (counter2 / maxCounter);
				ajustBars()
				
			}
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Mouse.hide();
			
			ajustBars();
			
			//onhandig maar werkt voor nu
			btn1 = new BtnStart();
			btn1.x = 280;
			btn1.y = 300;
			addChild(btn1);
			btn1.visible = true;
			
			btn1_1 = new BtnStart2();
			btn1_1.x = 280;
			btn1_1.y = 300;
			addChild(btn1_1);
			btn1_1.visible = false;
			
			btn2 = new BtnStart();
			btn2.x = 280;
			btn2.y = 500;
			addChild(btn2);
			btn2.visible = true;
			
			btn2_1 = new BtnStart2();
			btn2_1.x = 280;
			btn2_1.y = 500;
			addChild(btn2_1);
			btn2_1.visible = false;
			
			btn3 = new BtnStart();
			btn3.x = 280;
			btn3.y = 700;
			addChild(btn3);
			btn3.visible = true;
			
			btn3_1 = new BtnStart2();
			btn3_1.x = 280;
			btn3_1.y = 700;
			addChild(btn3_1);
			btn3_1.visible = false;
			
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function ajustBars ():void
		{
			//var bar1:Shape = new Shape;
			bar1.graphics.beginFill(0xff0000);
			bar1.graphics.drawRoundRect(-100, 0, 200, 20, 8, 8);
			bar1.graphics.endFill();
			bar1.y = 380;
			bar1.scaleX = bar1sc;
			addChild(bar1);
			
			//var bar2:Shape = new Shape;
			bar2.graphics.beginFill(0xff0000);
			bar2.graphics.drawRoundRect(-100, 0, 200, 20, 8, 8);
			bar2.graphics.endFill();
			bar2.y = 580;
			bar2.scaleX = bar2sc;
			addChild(bar2);
			
			//var bar3:Shape = new Shape;
			bar3.graphics.beginFill(0xff0000);
			bar3.graphics.drawRoundRect(-100, 0, 200, 20, 8, 8);
			bar3.graphics.endFill();
			bar3.scaleX = bar3sc;
			bar3.y = 780;
			bar3.x = bar2.x = bar1.x = 280;
			x = 100;
			addChild(bar3);
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE )
			{
				counter2 ++;
				
				if(released == true){
				counter ++;
				released = false;
				if (counter > 3)
				{
					counter = 1;
				}
				
					if (counter == 1)
					{
						bar3sc = 0;
						Toggle1();
						myTimer.start();
					}
					if (counter == 2)
					{
						bar1sc = 0;
						Toggle2();
						myTimer.start();
					}
					if (counter == 3)
					{
						bar2sc = 0;
						Toggle3();
						myTimer.start();
					}
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE )
			{
				released = true;
				
				if (counter == 1)
					{
						Toggle1();
						
						counter2 = 0;
						removeChild(bar1);
						myTimer.stop();
						myTimer.reset();
					}
					if (counter == 2)
					{
						Toggle2();
						
						counter2 = 0
						removeChild(bar2);
						myTimer.stop();
						myTimer.reset();
					}
					if (counter == 3)
					{
						Toggle3();
						
						counter2 = 0;
						removeChild(bar3);
						myTimer.stop();
						myTimer.reset();
					}
			}
		}
		
		private function Toggle1():void
		{
			if (btn1.visible == true)
			{
				btn1.visible = false;
			}
			else
			{
				btn1.visible = true;
			}
			
			if (btn1_1.visible == true)
			{
				btn1_1.visible = false;
			}
			else
			{
				btn1_1.visible = true;
			}
		}
		private function Toggle2():void
		{
			if (btn2.visible == true)
			{
				btn2.visible = false;
			}
			else
			{
				btn2.visible = true;
			}
			
			if (btn2_1.visible == true)
			{
				btn2_1.visible = false;
			}
			else
			{
				btn2_1.visible = true;
			}
		}
		private function Toggle3():void
		{
			if (btn3.visible == true)
			{
				btn3.visible = false;
			}
			else
			{
				btn3.visible = true;
			}
			
			if (btn3_1.visible == true)
			{
				btn3_1.visible = false;
			}
			else
			{
				btn3_1.visible = true;
			}
		}
		
	}

}