package
{
	import flash.display.Shader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.display.Shape;
	
	public class Main extends Sprite
	{
		private var player:Shape;
		private var speed:Number = 8;
		private var gravity:Number = 10;
		private var jumpPower:Number = 0;
		private var rotationSpeed:Number = 0;
		private var jumpStart:Number = 0;
		private var scoreboard:scoreBoard;
		private var jumping:Boolean = false;
		private var i:int;
		private var resetToStart:Boolean = false;
		private var teleporters:Array;
		private var grounds:Array;
		private var obstacles:Array;
		private var resetX:Number;
		private var music:Music = new Music();
		private var resetY:Number;
		private var lvlCounter:int = 0;		
		
		public function Main() 
		{
			Mouse.hide();
			music.playMusic("../bin/bensound-dance(duringTheGame).mp3");
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}	
			
		private function onUpdate (e:Event) :void 
		{
			player.x += speed;
			player.y += gravity;
			
			if (resetToStart)
			{
				player.x = resetX;
				player.y = resetY;
				resetToStart = false;
			}
			
			if (jumping)
			{
				player.y -= jumpPower;
				jumpPower -= 2;
			}
			
			if (player.y + gravity < jumpStart)
			{
				player.y += gravity;
			}
			
			else
			{
				jumping = false;
			}	
			
		}
		
		private function collision(coll) {
			if (player.hitTestObject(teleporters[0])) {					
				player.x = 1100;
				player.y = 500;
				resetX = 1100;
				resetY = 500;
				
				speed -= speed * 2;
			}
			if (player.hitTestObject(teleporters[1]))
			{
				player.x = 0;
				player.y = 800;
				resetX = 0;
				resetY = 800;
				
				speed -= speed * 2;
			}
			if (player.hitTestObject(teleporters[2]))
			{
				player.x = 0;
				player.y = 200;
				resetX = 0;
				resetY = 200;
				
				lvlCounter ++;
				
				jumping = false;
				
				newLVL();
			}
			
			for (var i = 0; i < grounds.length; i++)
			{
				if (player.hitTestObject(grounds[i])) 
				{
					player.y = grounds[i].y - 50;
				}
			}
			
			for (var i = 0; i < obstacles.length; i++)
			{
				if (player.hitTestObject(obstacles[i])) 
				{
					resetToStart = true;
					scoreboard.score ++;
				}
			}
			

		}
		
		private function OnKeyDown(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.SPACE)
			{
				if (!jumping)
				{
					jumpPower = 43;
					jumpStart = player.y;
					jumping = true;
					
				}
			}
		}
		private function drawTeleporter(_x:Number, _y:Number):void
		{			
			var teleporter: Sprite = new Sprite();
			teleporter.graphics.beginFill(0Xffffff);
			teleporter.graphics.drawRect(0, 0, 1, 200);
			teleporter.x = _x;
			teleporter.y = _y;
			teleporter.graphics.endFill();
			
			teleporters.push(teleporter);
			
		}
		
		private function drawGround(_x:Number, _y:Number):void
		{			
			var ground: Sprite = new Sprite();
			ground.graphics.beginFill(0x0ff0ff);
			ground.graphics.drawRect(0, 0, 1200, 40);
			ground.x = _x;
			ground.y = _y;
			ground.graphics.endFill();
			
			grounds.push(ground);
			
			addChild(ground);
		}
		
		private function drawObstacle(_x:Number, _y:Number, scaleX:Number, scaleY:Number):void 
		{
			var obstacle: Sprite = new Sprite();
			obstacle.graphics.beginFill(0x0ff0ff);
			obstacle.graphics.drawRect(0, 0, 100, 100);
			obstacle.x = _x;
			obstacle.y = _y;
			obstacle.scaleX = scaleX;
			obstacle.scaleY = scaleY;
			obstacle.graphics.endFill();
			
			obstacles.push(obstacle);
			
			addChild(obstacle);
		}
		
		private function background():void
		{
			var background: Sprite = new Sprite();
			background.graphics.beginFill(0x424242);
			background.graphics.drawRect(0, 0, 1200, 900);
			background.graphics.endFill();
			
			addChildAt(background, 0);	
		}
		
		private function newLVL() :void
		{
			for (var i = obstacles.length-1; i >= 0; i--)
			{
				removeChild(obstacles[i]);
				obstacles.splice(i, 1);			
			}
			//removeChild(background);
			
			//lvl 2
			if (lvlCounter == 1)
			{
				drawObstacle(600, 150, 0.5, 0.5);
				drawObstacle(400, 460, 0.2, 0.4);
				drawObstacle(800, 460, 0.2, 0.4);
				drawObstacle(300, 750, 0.5, 0.5);
				drawObstacle(900, 750, 0.5, 0.5);
			}
			
			//lvl 3
			
			if (lvlCounter == 2)
			{
				//Ground 1.
			   drawObstacle(325, 150, 0.5, 0.5);
			   drawObstacle(700, 150, 0.5, 0.5);
			   //Ground 2.
			   drawObstacle(700, 450, 0.5, 0.5);
			   drawObstacle(400, 450, 0.5, 0.5);
			   //Ground 3.
			   drawObstacle(300, 750, 0.5, 0.5);
			   drawObstacle(520, 750, 0.5, 0.5);
			   drawObstacle(780, 750, 0.5, 0.5);
			}
			
			//lvl 4
			
			if (lvlCounter == 3)
			{
				drawObstacle(400, 150, 0.9, 0.5);
				drawObstacle(800, 110, 0.5, 0.9);
				drawObstacle(300, 450, 0.5, 0.5);
				drawObstacle(450, 350, 4, 0.3);
				drawObstacle(300, 750, 0.5, 0.5);
				drawObstacle(425, 650, 4, 0.3);
				drawObstacle(925, 750, 0.5, 0.5);
			}
			
			//lvl 5
			
			if (lvlCounter == 4)
			{
				//Ground 1.
			   drawObstacle(300, 150, 0.5, 0.5);
			   drawObstacle(500, 150, 0.5, 0.5);
			   drawObstacle(700, 150, 0.5, 0.5);
			   drawObstacle(900, 150, 0.5, 0.5);
			   //Ground 2.
			   drawObstacle(200, 450, 0.5, 0.5);
			   drawObstacle(400, 450, 0.5, 0.5);
			   drawObstacle(600, 450, 0.5, 0.5);
			   drawObstacle(800, 450, 0.5, 0.5);
			   //Ground 3.
			   drawObstacle(300, 750, 0.5, 0.5);
			   drawObstacle(500, 750, 0.5, 0.5);
			   drawObstacle(700, 750, 0.5, 0.5);
			   drawObstacle(900, 750, 0.5, 0.5);
			}
			
			//lvl 6
			
			if (lvlCounter == 5)
			{
				//Ground 1.
			   drawObstacle(300, 150, 0.5, 0.5);
			   drawObstacle(500, 150, 0.4, 0.5);
			   drawObstacle(800, 150, 0.5, 0.5);
			   //Ground 2.
			   drawObstacle(200, 450, 0.5, 0.5);
			   drawObstacle(400, 399, 0.5, 0.5);
			   drawObstacle(600, 490, 0.1, 0.1);
			   drawObstacle(800, 450, 0.5, 0.5);
			   //Ground 3.
			   drawObstacle(300, 750, 0.5, 0.5);
			   drawObstacle(500, 750, 0.5, 0.5);
			   drawObstacle(850, 750, 0.5, 0.5);
			}
			
			//lvl 7
			
			if (lvlCounter == 6)
			{
				//Ground 1.
			   drawObstacle(325, 175, 0.2, 0.25);
			   drawObstacle(346, 165, 0.2, 0.35);
			   drawObstacle(367, 155, 0.2, 0.45);
			   drawObstacle(600, 128, 1.4, 0.2);
			   drawObstacle(830, 160, 0.4, 0.4);
			   //Ground 2.
			   drawObstacle(800, 426,   1, 0.2);
			   drawObstacle(650, 460, 0.4, 0.4);
			   drawObstacle(450, 460, 0.4, 0.4);
			   drawObstacle(200, 460, 0.4, 0.4);
			   //Ground 3.
			   drawObstacle(300, 770, 0.3, 0.3);
			   drawObstacle(410, 719, 0.5, 0.2);
			   drawObstacle(540, 770, 0.3, 0.3);
			   drawObstacle(780, 770, 0.3, 0.3);
			}
			
			//lvl 8
			
			if (lvlCounter == 7)
			{
				 //Ground 1.
			   drawObstacle(275, 150, 0.7, 0.5);
			   drawObstacle(475, 99, 0.5, 0.5);
			   drawObstacle(725, 150, 0.5, 0.5);
			   drawObstacle(975, 99, 0.5, 0.5);
			   drawObstacle(1150, 150, 0.5, 0.5);
			   //Ground 2.
			   drawObstacle(150, 450, 0.5, 0.5);
			   drawObstacle(350, 450, 0.5, 0.5);
			   drawObstacle(500, 420, 0.4, 0.2);   
			   drawObstacle(625, 420, 0.4, 0.2);
			   drawObstacle(800, 450, 0.5, 0.5);
			   drawObstacle(860, 240, 0.5, 0.8);
			   //Ground 3.
			   drawObstacle(1030, 750, 0.5, 0.5);
			   drawObstacle(830, 750, 0.5, 0.5);
			   drawObstacle(630, 750, 0.5, 0.5);
			   drawObstacle(430, 750, 0.5, 0.5);
			   drawObstacle(230, 750, 0.5, 0.5);
			}
			
			//lvl 9
			
			if (lvlCounter == 8)
			{
				 //ground1
				drawObstacle(400, 150, 1, 0.5);
				drawObstacle(800, 100, 0.5, 1);
				//ground2
				drawObstacle(100, 450, 1, 0.5);
				drawObstacle(250 , 350, 4.5 , 0.3);
				drawObstacle(750, 450, 1, 0.5);
				//ground3
				drawObstacle(400, 700, 0.5, 1);
				drawObstacle(600, 690, 0.5, 0.5);
				drawObstacle(800, 700, 0.5, 1);
			}
			
			//lvl 10
			
			if (lvlCounter == 9)
			{
				speed += 5;
				drawObstacle(550, 450, 1.5, 0.5);
				drawObstacle(400, 750, 1.5, 0.5);
				drawObstacle(800, 750, 1.5, 0.5);
			}
			
			//lvl 11
			
			if (lvlCounter == 10)
			{
				drawObstacle(500, 150, 2, 0.5);
				drawObstacle(200, 450, 1, 0.5);
				drawObstacle(800, 450, 1, 0.5);
				drawObstacle(300, 750, 0.5, 0.5);
				drawObstacle(425, 650, 4, 0.3);
				drawObstacle(900, 750, 0.5, 0.5);
			}
			
			//lvl 12
			
			if (lvlCounter == 11)
			{
				drawObstacle(280, 150, 0.5, 0.5);
				drawObstacle(650, 99, 0.5, 0.5);
				drawObstacle(1030, 150, 0.5, 0.5);
			   //Ground 2.
				drawObstacle(400, 450, 0.5, 0.5);
				drawObstacle(650, 350, 0.5, 0.5);
				drawObstacle(820, 450, 0.5, 0.5);
			   //Ground 3.
				drawObstacle(280, 750, 0.5, 0.5);
				drawObstacle(450, 650, 0.5, 0.5);
				drawObstacle(650, 750, 0.5, 0.5);
				drawObstacle(780, 750, 0.5, 0.5);
				drawObstacle(1030, 750, 0.5, 0.5);
			}
			
			//lvl 13
			
			if (lvlCounter == 12)
			{
				speed -= 5;
				
				//Ground 1.
				drawObstacle(250, 150, 0.5, 0.5);
				drawObstacle(475, 150, 0.5, 0.5);
				drawObstacle(675, 120, 1, 0.2);
				drawObstacle(925, 150, 0.5, 0.5);
				//Ground 2.
				drawObstacle(100, 450, 0.5, 0.5);
				drawObstacle(400, 220, 0.5, 0.8);
				drawObstacle(400, 450, 0.5, 0.5);
				drawObstacle(575, 420, 1.2, 0.2);
				drawObstacle(800, 450, 0.5, 0.5);
				
				//Ground 3.
				drawObstacle(150, 719, 3, 0.1);
				drawObstacle(600, 750, 0.5, 0.5);
				drawObstacle(830, 750, 0.5, 0.5);
				drawObstacle(1030, 750, 0.5, 0.5);				
			}
			
			//lvl 14
			
			if (lvlCounter == 13)
			{
			  speed -= 3;
				//Ground 1.
			  drawObstacle(250, 150, 0.3, 0.5);
			  drawObstacle(370, 119, 2, 0.2);
			  drawObstacle(650, 150, 0.3, 0.5);
			  drawObstacle(950, 150, 0.3, 0.5);
			  drawObstacle(1020, 1, 0.3, 0.1);
			  
			  //Ground 2.
			  drawObstacle(900, 450, 0.3, 0.5);
			  drawObstacle(750, 450, 0.3, 0.5);
			  drawObstacle(600, 450, 0.3, 0.5);
			  drawObstacle(450, 450, 0.3, 0.5);
			  drawObstacle(300, 450, 0.3, 0.5);
			  drawObstacle(150, 450, 0.3, 0.5);
			  drawObstacle(0, 450, 0.3, 0.5);
			  
			  //Ground 3.
			  //T
			  drawObstacle(0, 739, 12, 0.1);
			  drawObstacle(100, 709, 0.3, 0.3);
			  drawObstacle(100, 679, 0.3, 0.3);
			  drawObstacle(100, 649, 0.3, 0.3);
			  drawObstacle(100, 619, 0.3, 0.3);
			  drawObstacle(100, 589, 0.3, 0.3);
			  drawObstacle(100, 619, 0.3, 0.3);
			  drawObstacle(70, 589, 0.3, 0.3);
			  drawObstacle(40, 589, 0.3, 0.3);
			  drawObstacle(130, 589, 0.3, 0.3);
			  drawObstacle(160, 589, 0.3, 0.3);
			  //I
			  
			  drawObstacle(225, 709, 0.3, 0.3);
			  drawObstacle(225, 679, 0.3, 0.3);
			  drawObstacle(225, 649, 0.3, 0.3);
			  drawObstacle(225, 619, 0.3, 0.3);
			  drawObstacle(225, 589, 0.3, 0.3);
			  
			  
			  //-
			  drawObstacle(255, 649, 0.3, 0.3);
			  drawObstacle(285, 649, 0.3, 0.3);
			  
			  //I
			  drawObstacle(315, 709, 0.3, 0.3);
			  drawObstacle(315, 679, 0.3, 0.3);
			  drawObstacle(315, 649, 0.3, 0.3);
			  drawObstacle(315, 619, 0.3, 0.3);
			  drawObstacle(315, 589, 0.3, 0.3);
			  
			  //E
			  drawObstacle(375, 709, 0.3, 0.3);
			  drawObstacle(375, 679, 0.3, 0.3);
			  drawObstacle(375, 649, 0.3, 0.3);
			  drawObstacle(375, 619, 0.3, 0.3);
			  drawObstacle(375, 589, 0.3, 0.3);
			  //-
			  drawObstacle(405, 709, 0.3, 0.3);
			  drawObstacle(435, 709, 0.3, 0.3);
			  drawObstacle(405, 649, 0.3, 0.3);
			  drawObstacle(435, 649, 0.3, 0.3);
			  drawObstacle(405, 589, 0.3, 0.3);
			  drawObstacle(435, 589, 0.3, 0.3);
			  
			  //O
			  drawObstacle(495, 709, 0.3, 0.3);
			  drawObstacle(495, 679, 0.3, 0.3);
			  drawObstacle(495, 649, 0.3, 0.3);
			  drawObstacle(495, 619, 0.3, 0.3);
			  drawObstacle(495, 589, 0.3, 0.3);
			  
			  drawObstacle(525, 709, 0.3, 0.3);
			  drawObstacle(555, 709, 0.3, 0.3);
			  
			  drawObstacle(525, 589, 0.3, 0.3);
			  drawObstacle(555, 589, 0.3, 0.3);
			  
			  drawObstacle(584, 709, 0.3, 0.3);
			  drawObstacle(584, 679, 0.3, 0.3);
			  drawObstacle(584, 649, 0.3, 0.3);
			  drawObstacle(584, 619, 0.3, 0.3);
			  drawObstacle(584, 589, 0.3, 0.3);
			}
			
			// lvl 15
			
			if (lvlCounter == 14)
			{
				
				//ground 1
				drawObstacle(200, 100, 1, 0.25);
				drawObstacle(600, 150, 0.25, 0.5);
				drawObstacle(400, 150, 0.25, 0.5);
				drawObstacle(800, 150, 0.25, 0.5);
				drawObstacle(900, 100, 1, 0.25);
				//ground2
				drawObstacle(600, 480, 0.5, 0.25);
				drawObstacle(700, 400, 0.5, 0.25);
				drawObstacle(450, 400, 0.5, 0.25);
				drawObstacle(850, 480, 0.5, 0.25);
				drawObstacle(950, 400, 0.5, 0.25);
				drawObstacle(700, 400, 0.5, 0.25);
				drawObstacle(350, 480, 0.5, 0.25);
				drawObstacle(450, 400, 0.5, 0.25);
				drawObstacle(200, 400, 0.5, 0.25);
				//ground3
				drawObstacle(600, 800, 0.5, 0.1);
				drawObstacle(400, 800, 0.5, 0.1);
				drawObstacle(200, 800, 0.5, 0.1);
				drawObstacle(800, 800, 0.5, 0.1);
				drawObstacle(1000, 800, 0.5, 0.1);
			}
			
			//lvl End
			if (lvlCounter == 15)
			{
				lvlCounter == 0;
			}
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			background();
			teleporters = new Array();
			grounds = new Array();
			obstacles = new Array();
			resetX = 0;
			resetY = 150;
			
			player = new Shape(); 
			player.graphics.beginFill(0xFF0000); 
			player.graphics.drawRect(0, 0, 100,100);
			player.x = 100;
			player.y = 200;
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			player.graphics.endFill();
			
			//lvl1!
			drawObstacle(600, 450, 0.5, 0.5);
			drawObstacle(500, 750, 0.5, 0.5);
			drawObstacle(700, 750, 0.5, 0.5);
			
			drawTeleporter(1200,0);
			drawTeleporter(0,300);
			drawTeleporter(1200, 600);
				
			drawGround(0, 200);
			drawGround(0, 500);
			drawGround(0, 800);
			
			scoreboard = new scoreBoard;
			addChild(scoreboard);
			addChild(player);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			addEventListener(Event.ENTER_FRAME, onUpdate);
			addEventListener(Event.ENTER_FRAME, collision);
		}
	}
}