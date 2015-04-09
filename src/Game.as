package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Game extends Sprite
	{
		private var main:Main;
		private var credit:Credits;
		private var mainMenu:MainMenu;
		private var instruct:InstructPage;
		private var openInstruct:String = "startInstruct";
		private var openCredits:String = "startCredits";
		private var openGame:String = "startGame";
		private var openMenu:String = "startMenu";
		private var playAgain:String = "playAgain";
		private var counter:int = 1;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			startMenu(e);
		}
		
		private function startMenu(e:Event):void
		{
			counter = 1;
			if (counter >= 2) {
				removeChild(main);
				main = null;
				removeChild(credit);
				credit = null;
				removeChild(instruct);
				instruct = null;
			}
			mainMenu = new MainMenu();
			addChild(mainMenu);
			mainMenu.addEventListener(openGame, startGame);
			mainMenu.addEventListener(openCredits, startCredits);
			mainMenu.addEventListener(openInstruct, startInstruct);
			mainMenu.addEventListener(openMenu, startMenu);
		}
		
		private function startGame(e:Event):void
		{
			removeChild(mainMenu);
			mainMenu = null;
			
			main = new Main();
			addChild(main);
			
			counter ++;
			main.addEventListener(openMenu, startMenu);
			main.addEventListener(openMenu, startMenu);  
		}
		private function startCredits(e:Event):void
		{
			removeChild(mainMenu);
			mainMenu = null;
			
			credit = new Credits();
			addChild(credit);
			
			counter ++;
			credit.addEventListener(openCredits, startCredits);
			credit.addEventListener(openMenu, startMenu);
		}
		private function startInstruct(e:Event):void
		{
			removeChild(mainMenu);
			mainMenu = null;
			
			instruct = new InstructPage();
			addChild(instruct);
			
			counter ++;
			instruct.addEventListener(openInstruct, startInstruct);
			instruct.addEventListener(openMenu, startMenu);
		}
	}
}