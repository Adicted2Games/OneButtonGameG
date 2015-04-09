package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author sjoerd
	 */
	public class Background2 extends Sprite
	{
		[Embed(source="../img/credits.png")]
		private var BackgroundImage:Class;
		
		private var bgImage:Bitmap;
		
		public function Background2() 
		{
			//constructor
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			//eventlistener maken
			this.scaleX = 1;
			this.scaleY = 1;
			
			
			
		}
		private function init(e:Event = null):void
		{
			bgImage = new BackgroundImage();
			addChild (bgImage);
		}
	}

}
//package  
//{
	//import flash.display.Bitmap;
	//import flash.display.Sprite;
	//import flash.events.Event;
	//import flash.net.URLRequest;
	///**
	 //* ...
	 //* @author sjoerd
	 //*/
	//public class Background extends Sprite
	//{
		//
		//private var bgimg:String = "../img/mainMenu.png";
		//private var BackgroundImage:Class;
		//private var request:URLRequest;
		//private var bgImage:Bitmap;
		//
		//public function Background() 
		//{
			////constructor
			////this.addEventListener(Event.ADDED_TO_STAGE, init);
			////eventlistener maken
			////this.scaleX = 1;
			////this.scaleY = 1;
		//}
		//public function backgroundLoad(bgimg:String):void
		//{
			//request = new URLRequest(bgimg);
			//bgImage = new BackgroundImage(bgimg);
			//addChild (bgImage);
		//}
	//}
//
//}