package{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	
	public class MatchGame extends MovieClip{
		//声明一个容器
		private var container:Sprite;
		//声明一个数组对象，用于存储所创建的棋子
		private var aCircles:Array;
		//声明一个数组对象，用于存储所创建的机器人
		private var aRobots:Array;
		//声明一个整型变量，用来代表棋子的基数
		private var numCircles:int;
		//创建数组对象aGrid来管理网格，数组中的元素为Point对象，
		//每个point对象中都存储着单元格的坐标信息
		private var aGrid:Array;
		//变量gridSize用来存储单元格的边长值
		private var gridSize:Number;
		
		//声明一个变量，用于控制游戏是否开始
		private var is_startGame:Boolean;
		
		//棋盘的四个边界
		private var rectLeft:Number;
		private var rectRight:Number;
		private var rectTop:Number;
		private var rectBottom:Number;
		//机器人的四个边界
		private var robotLeft:Number = 70;
		private var robotRight:Number = 490;
		private var robotTop:Number = 70;
		private var robotBottom:Number = 420;
		
		//机器人的当前运动方向
		//1表示机器人向下走
		//2表示机器人向上走
		//3表示机器人向右走
		//4表示机器人向左走
		private var currentDirection:int;
		//机器人的前一次的运动方向
		private var precedingDirection:int;
		
		//声明变量RobotCurrentX和RobotCurrentY，表示当前界面上的
		//机器人所处的坐标位置
		private var RobotCurrentX:int;
		private var RobotCurrentY:int;
		
		//声明一个机器人前的变量，用于存储位于当前机器人前面的棋子的下标值
		private var circleBeforeRobot:int;
		
		//声明一个25x25的一个棋盘坐标点
		private var point01:Point;private var point02:Point;private var point03:Point;private var point04:Point;private var point05:Point;
		private var point06:Point;private var point07:Point;private var point08:Point;private var point09:Point;private var point10:Point;
		private var point11:Point;private var point12:Point;private var point13:Point;private var point14:Point;private var point15:Point;
		private var point16:Point;private var point17:Point;private var point18:Point;private var point19:Point;private var point20:Point;
		private var point21:Point;private var point22:Point;private var point23:Point;private var point24:Point;private var point25:Point;
		
		//声明一个数组aPictures，用来存储图案所在的帧序号
		private var aPictures:Array = new Array();
		
		private var clicks:Boolean = false;
		private var firstClick:int;
		private var secondClick:int;
		
		//尝试次数
		private var tries:int;
		//正确次数
		private var correct:int;
		
		//棋子基数的增加量
		private var numLevel:int;
		//下一关按钮的状态
		private var bNextState:Boolean;
		
		public function MatchGame():void{
			ExternalInterface.addCallback("asfunc",fromjs);
			//指定舞台在Flash Player或浏览器中的对齐方式，并使swf文件大小固定
			//即使播放器窗口的大小改变，它也会保持不变
			this.is_startGame = false;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//创建容器，并将容器加入舞台
			container = new Sprite();
			addChild(container);
			
			//给舞台上注册一个键盘按下事件
			//stage.addEventListener(KeyboardEvent.KEY_DOWN,keyevt);
			
			//设置下一关按钮为不可见状态
			bNext.visible = false;
			
			//使闯关成功动画置为不可见状态并使其停止
			mWin.visible = false;
			mWin.stop();
			
			//给开始按钮添加鼠标单击事件
			//bStart.addEventListener(MouseEvent.CLICK,startGame);
			
			//给下一关按钮添加单击事件
			//bNext.addEventListener(MouseEvent.CLICK,nextGame);
			
			//初始化棋盘上的个点坐标
			makePoint();
			
			//设置棋子的基数
			numCircles = 1;
			
			//设置棋子的基数增加值
			numLevel = 1;
		}
		private function fromjs(value:String):void
		{
			//tTries.text = value;
			if(this.is_startGame == false)
			{
				if(value == "start")
					startRobotGame();
				else if(value == "next" && this.bNextState == true)
				    nextRobotGame();
			}
			else
			{
				switch(value)
				{
					case "godown":
						ControlDown();
						break;
					case "goup":
						ControlUp();
						break;
					case "goleft":
						ControlLeft();
						break;
					case "goright":
						ControlRight();
						break;
					case "turn":
						TurnCircle();
						break;
					default:
						break;
				}
			}
			//else if(value == "godown")
			//{
			//	ControlDown();
			//}
			//else if(value == "next")
			//{
			//	this.nextRobotGame();
			//}
		}
		//建立事件侦听函数
		private function keyevt(event:KeyboardEvent):void
		{
			//获取当前键盘代码
			switch(event.keyCode)
			{
				case 87:     //按下W键
				     //aRobots[1].play();
					 ControlUp();
					 break;
				case 83:     //按下S键
				     //aRobots[0].play();
					 ControlDown();
					 break;
				case 65:     //按下A键
				     //aRobots[3].play();
					 ControlLeft();
					 break;
				case 68:     //按下D键
				     //aRobots[2].play();
					 ControlRight();
					 break;
				case 32:    //按下空格键
				     TurnCircle();
					 break;
				default:
				     break;
			}
		}
		//翻转棋子，使其显示
		//首先根据this.circleBeforeRobot的值进行判断，如果其值不为-1，
		//则表示机器人已经撞上棋子，此时可以直接翻转棋子；另外一种情况是:
		//机器人刚刚到达但还没有撞上棋子，此时也可以翻转棋子
		private function TurnCircle():void
		{
			if(this.is_startGame == true)
			{
			//机器人刚刚到达，还没有撞上，判断一下下一步是否能撞上棋子
			if(this.circleBeforeRobot == -1)
			{
				this.RobotHitCircle();
			}
			//判断该机器人可否翻转棋子
			if(this.circleBeforeRobot != -1)
			{
				var i:int = this.circleBeforeRobot;
				if(clicks == false)
				{
					//evt.target.circleOpen();
					this.aCircles[i].circleOpen();
					//firstClick = evt.target.index;
					firstClick = this.aCircles[i].index;
					clicks = true;
				}
				else
				{
					if(this.aCircles[i].index != firstClick)   //evt.target.index != firstClick
					{
						//evt.target.circleOpen();
						this.aCircles[i].circleOpen();
						//secondClick = evt.target.index;
						secondClick = this.aCircles[i].index;
						if(this.aCircles[i].pictureIndex == aCircles[firstClick].pictureIndex) //evt.target.pictureIndex == aCircles[firstClick].pictureIndex
						{
							//如果两幅图片匹配则使两幅图片逐渐消失
							//添加一个500毫秒的延迟，这样使图片消失时显得更自然一点
							//aCircles[firstClick].removeEventListener(MouseEvent.CLICK,clickCircleHandler);
							//evt.target.removeEventListener(MouseEvent.CLICK,clickCircleHandler);
							var disDelay:Timer = new Timer(500,1);
							disDelay.start();
							disDelay.addEventListener(TimerEvent.TIMER,Match);
						
							trace("匹配");
						}
						else
						{
							//如果两幅图片不同，则使两幅图片自动转回去
							//添加一个300毫秒的延迟，这样使图片转回去时显得更自然一点
							var delay:Timer = new Timer(300,1);
							delay.start();
							delay.addEventListener(TimerEvent.TIMER,noMatch);
						
							trace("不匹配");
						}
						//两次不同的单击结束之后，使单击状态置为可用状态
						clicks = false;
					}
				}
			}
			}
		}
		//判断某一机器人是否在活动范围内
		private function CheckRobotRange(x:int,y:int):Boolean
		{
			if(this.currentDirection == 1 && y == this.robotBottom)
				return false;
			else if(this.currentDirection == 2 && y == this.robotTop)
				return false;
			else if(this.currentDirection == 3 && x == this.robotRight)
			    return false;
			else if(this.currentDirection == 4 && x == this.robotLeft)
				return false;
			else
				return true;
		}
		//机器人与棋子的碰撞检测
		private function RobotHitCircle():Boolean
		{
			var tempX:int = 0;
			var tempY:int = 0;
			switch(this.currentDirection)
			{
				case 1:
					 tempX = this.RobotCurrentX;
					 tempY = this.RobotCurrentY + 35;
					 break;
				case 2:
				     tempX = this.RobotCurrentX;
					 tempY = this.RobotCurrentY - 35;
					 break;
				case 3:
				     tempX = this.RobotCurrentX + 35;
					 tempY = this.RobotCurrentY;
					 break;
				case 4:
					 tempX = this.RobotCurrentX - 35;
					 tempY = this.RobotCurrentY;
					 break;
				default:
				     break;
			}
			for(var i:int = 0; i < this.numCircles*2; i++)
			{
				if((this.aCircles[i].x == tempX) && (this.aCircles[i].y == tempY))
				{
					trace("判断成功");
					trace(this.circleBeforeRobot);
					trace(this.aCircles[i].is_del);
					if(this.aCircles[i].is_del == 1)
					{
						this.circleBeforeRobot = i;
						break;
					}
					else if(this.aCircles[i].is_del == -1)
					{
						this.circleBeforeRobot = -1;
					}
				}
			}
			if(this.circleBeforeRobot == -1)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		//控制向下的机器人函数
		private function ControlDown():void
		{
			if(this.is_startGame == true)
			{
			if(this.currentDirection != 1)
			{
				aRobots[0].x = this.RobotCurrentX;
				aRobots[0].y = this.RobotCurrentY;
				aRobots[this.currentDirection - 1].visible = false;
				aRobots[0].visible = true;
				
				//将机器人的位置与当前位置实时对应
				aRobots[0].currentX = this.RobotCurrentX;
				aRobots[0].currentY = this.RobotCurrentY;
				
				//将当前的运动方向置为向下
				this.currentDirection = 1;
				//将其前面的障碍物置为空，也就是此时前面没有棋子
				this.circleBeforeRobot = -1;
			}
			
			//将当前运动的机器人的坐标值赋给全局的机器人的实时坐标位置
			//方便将来控制机器人的转向
			this.RobotCurrentX = aRobots[0].currentX;
			this.RobotCurrentY = aRobots[0].currentY;
			
			trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
			trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
				
			if(CheckRobotRange(aRobots[0].currentX,aRobots[0].currentY))
			{
				if(!this.RobotHitCircle())
				{
					aRobots[0].play();
					aRobots[0].currentY = aRobots[0].y + 35;
			
					this.RobotCurrentX = aRobots[0].currentX;
					this.RobotCurrentY = aRobots[0].currentY;
			
					trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
					trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
					trace("走一步成功");
					//trace("X:"+aRobots[0].x);
					//trace("Y:"+aRobots[0].y);
				}
				else
				{
					trace("前面有棋子不可走");
				}
			}
			else
			{
				trace("已经到达边界，不可再走");
			}
			}
		}
		//控制向上的机器人函数
		private function ControlUp():void
		{
			if(this.is_startGame == true)
			{
			if(this.currentDirection != 2)
			{
				aRobots[1].x = this.RobotCurrentX;
				aRobots[1].y = this.RobotCurrentY;
				aRobots[this.currentDirection - 1].visible = false;
				aRobots[1].visible = true;
				//将机器人的位置与当前位置实时对应
				aRobots[1].currentX = this.RobotCurrentX;
				aRobots[1].currentY = this.RobotCurrentY;
				
				//将当前的运动方向置为向下
				this.currentDirection = 2;
				//将其前面的障碍物置为空，也就是此时前面没有棋子
				this.circleBeforeRobot = -1;
			}
			
			//将当前运动的机器人的坐标值赋给全局的机器人的实时坐标位置
			//方便将来控制机器人的转向
			this.RobotCurrentX = aRobots[1].currentX;
			this.RobotCurrentY = aRobots[1].currentY;
			
			trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
			trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
				
			if(CheckRobotRange(aRobots[1].currentX,aRobots[1].currentY))
			{
				if(!this.RobotHitCircle())
				{
					aRobots[1].play();
					aRobots[1].currentY = aRobots[1].y - 35;
			
					this.RobotCurrentX = aRobots[1].currentX;
					this.RobotCurrentY = aRobots[1].currentY;
			
					trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
					trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
					trace("走一步成功");
					//trace("X:"+aRobots[1].x);
					//trace("Y:"+aRobots[1].y);
				}
				else
				{
					trace("前面有棋子不可走");
				}
			}
			else
			{
				trace("已经到达边界，不可再走");
			}
			}
		}
		//控制向右的机器人函数
		private function ControlRight():void
		{
			if(this.is_startGame == true)
			{
			if(this.currentDirection != 3)
			{
				aRobots[2].x = this.RobotCurrentX;
				aRobots[2].y = this.RobotCurrentY;
				aRobots[this.currentDirection - 1].visible = false;
				aRobots[2].visible = true;
				//将机器人的位置与当前位置实时对应
				aRobots[2].currentX = this.RobotCurrentX;
				aRobots[2].currentY = this.RobotCurrentY;
				
				//将当前的运动方向置为向下
				this.currentDirection = 3;
				//将其前面的障碍物置为空，也就是此时前面没有棋子
				this.circleBeforeRobot = -1;
			}
			
			//将当前运动的机器人的坐标值赋给全局的机器人的实时坐标位置
			//方便将来控制机器人的转向
			this.RobotCurrentX = aRobots[2].currentX;
			this.RobotCurrentY = aRobots[2].currentY;
			
			trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
			trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
				
			if(CheckRobotRange(aRobots[2].currentX,aRobots[2].currentY))
			{
				if(!this.RobotHitCircle())
				{
					aRobots[2].play();
					aRobots[2].currentX = aRobots[2].x + 35;
			
					this.RobotCurrentX = aRobots[2].currentX;
					this.RobotCurrentY = aRobots[2].currentY;
			
					trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
					trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
					trace("走一步成功");
					//trace("X:"+aRobots[2].x);
					//trace("Y:"+aRobots[2].y);
				}
				else
				{
					trace("前面有棋子不可走");
				}
			}
			else
			{
				trace("已经到达边界，不可再走");
			}
			}
		}
		//控制向左的机器人函数
		private function ControlLeft():void
		{
			if(this.is_startGame == true)
			{
			if(this.currentDirection != 4)
			{
				aRobots[3].x = this.RobotCurrentX;
				aRobots[3].y = this.RobotCurrentY;
				aRobots[this.currentDirection - 1].visible = false;
				aRobots[3].visible = true;
				//将机器人的位置与当前位置实时对应
				aRobots[3].currentX = this.RobotCurrentX;
				aRobots[3].currentY = this.RobotCurrentY;
				
				//将当前的运动方向置为向下
				this.currentDirection = 4;
				//将其前面的障碍物置为空，也就是此时前面没有棋子
				this.circleBeforeRobot = -1;
			}
			
			//将当前运动的机器人的坐标值赋给全局的机器人的实时坐标位置
			//方便将来控制机器人的转向
			this.RobotCurrentX = aRobots[3].currentX;
			this.RobotCurrentY = aRobots[3].currentY;
			
			trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
			trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
				
			if(CheckRobotRange(aRobots[3].currentX,aRobots[3].currentY))
			{
				if(!this.RobotHitCircle())
				{
					aRobots[3].play();
					aRobots[3].currentX = aRobots[3].x - 35;
			
					this.RobotCurrentX = aRobots[3].currentX;
					this.RobotCurrentY = aRobots[3].currentY;
			
					trace("当前页面上的机器人所处的坐标的X值:"+this.RobotCurrentX);
					trace("当前页面上的机器人所处的坐标的Y值:"+this.RobotCurrentY);
					trace("走一步成功");
					//trace("X:"+aRobots[3].x);
					//trace("Y:"+aRobots[3].y);
				}
				else
				{
					trace("前面有棋子不可走");
				}
			}
			else
			{
				trace("已经到达边界，不可再走");
			}
			}
		}
		private function initGame():void
		{   
		    //游戏开始
			this.is_startGame = true;
			//设置每个棋子的帧序号
			setUpPictures();
			
			//在舞台上显示机器人
			drawRobots();
			
			//在舞台上显示棋子
			drawCircles();
			
			//初始时机器人前面的棋子是没有的因此其值为-1
			this.circleBeforeRobot = -1;
			
			//初始时机器人的位置是固定的
			this.RobotCurrentX = 490;
			this.RobotCurrentY = 70;
			//机器人的状态是随机的，也就是说机器人的当前的运动方向是随机的
			//使用Math.random()*5获得一个0-5之间的数字
			this.currentDirection = 1 + Math.random()*3;
			this.precedingDirection = this.currentDirection;
			//显示机器人
			aRobots[this.currentDirection - 1].visible = true;
			
			//初始化尝试次数和正确次数
			tries=correct=0;
			//显示出来
			tTries.text = String(tries);
			tCorrect.text = String(correct);
			
			//设置下一关按钮的状态值
			bNextState = false;
		}
		
		//开始游戏按钮的响应函数
		private function startGame(evt:MouseEvent):void
		{
			startRobotGame();
			//单击完开始游戏按钮后，删除该按钮的单击响应事件
			bStart.removeEventListener(MouseEvent.CLICK,startGame);
		}
		private function startRobotGame():void
		{
			//清空棋盘
			clearScreen();
			
			//初始化游戏棋盘
			initGame();
		}
		private function nextRobotGame():void
		{
			if(this.bNextState == true)
			{
				//使闯关成功动画不可见
				mWin.visible = false;
				mWin.stop();
			
				//清屏
				clearScreen();
				if(bNextState)
				{
					//每进入下一关棋子数加1
					numCircles += numLevel;
				
					if(numCircles > 5)
					{
						numCircles = 1;
						numLevel = 1;
					}
					initGame();
				}
			}
		}
		//下一关按钮的响应函数
		private function nextGame(evt:MouseEvent):void
		{
			//使下一关按钮不可见
			bNext.visible = false;
			nextRobotGame();
		}
		
		//清屏函数
		private function clearScreen():void
		{
			while(container.numChildren)
			{
				container.removeChildAt(0);
			}
		}
		
		//执行创建机器人对象的任务
		private function drawRobots():void
		{
			aRobots = new Array();
			//添加一个向下的机器人
			aRobots[0] = new GoDown();
			aRobots[0].x = 490;
			aRobots[0].y = 70;
			aRobots[0].currentX = 490;
			aRobots[0].currentY = 70;
			container.addChild(aRobots[0]);
			aRobots[0].name = "DownRobot";
			aRobots[0].visible = false;
			
			//添加一个向上的机器人
			//机器人的四个状态只能有一个，所以显示一个
			aRobots[1] = new GoUp();
			aRobots[1].x = 490;
			aRobots[1].y = 70;
			aRobots[1].currentX = 490;
			aRobots[1].currentY = 70;
			container.addChild(aRobots[1]);
			aRobots[1].name = "UpRobot";
			aRobots[1].visible = false;
			
			//添加一个向右的机器人
			//机器人的四个状态只能有一个，所以显示一个
			aRobots[2] = new GoRight();
			aRobots[2].x = 490;
			aRobots[2].y = 70;
			aRobots[2].currentX = 490;
			aRobots[2].currentY = 70;
			container.addChild(aRobots[2]);
			aRobots[2].name = "RightRobot";
			aRobots[2].visible = false;
			
			//添加一个向左的机器人
			//机器人的四个状态只能有一个，所以显示一个
			aRobots[3] = new GoLeft();
			aRobots[3].x = 490;
			aRobots[3].y = 70;
			aRobots[3].currentX = 490;
			aRobots[3].currentY = 70;
			container.addChild(aRobots[3]);
			aRobots[3].name = "LeftRobot";
			aRobots[3].visible = false;
			
			//添加一个向下原地走的机器人
			aRobots[4] = new GoNotDown();
			//aRobots[4].x = 490;
			//aRobots[4].y = 70;
			container.addChild(aRobots[4]);
			aRobots[4].name = "DownNotRobots";
			aRobots[4].visible = false;
			
			//添加一个向上原地走的机器人
			aRobots[5] = new GoNotUp();
			//aRobots[5].x = 490;
			//aRobots[5].y = 70;
			container.addChild(aRobots[5]);
			aRobots[5].name = "UpNotRobots";
			aRobots[5].visible = false;
			
			//添加一个向右原地走的机器人
			aRobots[6] = new GoNotRight();
			//aRobots[6].x = 490;
			//aRobots[6].y = 70;
			container.addChild(aRobots[6]);
			aRobots[6].name = "RightNotRobots";
			aRobots[6].visible = false;
			
			//添加一个向左原地走的机器人
			aRobots[7] = new GoNotLeft();
			//aRobots[7].x = 490;
			//aRobots[7].y = 70;
			container.addChild(aRobots[7]);
			aRobots[7].name = "LeftNotRobots";
			aRobots[7].visible = false;
		}
		
		//执行创建棋子对象的任务
		private function drawCircles():void
		{
			makeGrid();
			
			aCircles = new Array();
			
			//为棋子赋随机的坐标值
			for(var i:int = 0;i < numCircles*2; i++){
				aCircles[i] = new Circle(i);
				//aCircles[i].x = Math.random()*100;
				//aCircles[i].y = Math.random()*100;
				//获得数组索引内的一个随机索引值
				var index:int = Math.floor(Math.random()*aGrid.length);
				//棋子坐标等于aGrid数组中某一元素的坐标值
				aCircles[i].x = aGrid[index].x;
				aCircles[i].y = aGrid[index].y;
				//使用过该索引位置的元素后，立即将其从aGrid中删除，
				//就可以保证此后不会从该数组中选中相同的元素
				aGrid.splice(index,1);
				//每张图片(每个棋子)的索引号
				aCircles[i].pictureIndex = aPictures[i];
				//通过控制帧数显示每个棋子
				//aCircles[i].gotoAndStop(aPictures[i]);
				//当鼠标放在上面的时候，使其变为手型
				//aCircles[i].buttonMode = true;
				//为每一个棋子添加一个单击响应事件
				//aCircles[i].addEventListener(MouseEvent.CLICK,clickCircleHandler);
				
				
				container.addChild(aCircles[i]);
			}
		}
		
		//初始化棋盘上的各个点
		private function makePoint():void{
			point01 = new Point(140,140);point02 = new Point(140,210);point03 = new Point(140,280);point04 = new Point(140,350);point05 = new Point(140,420);
			point06 = new Point(210,140);point07 = new Point(210,210);point08 = new Point(210,280);point09 = new Point(210,350);point10 = new Point(210,420);
			point11 = new Point(280,140);point12 = new Point(280,210);point13 = new Point(280,280);point14 = new Point(280,350);point15 = new Point(280,420);
			point16 = new Point(350,140);point17 = new Point(350,210);point18 = new Point(350,280);point19 = new Point(350,350);point20 = new Point(350,420);
			point21 = new Point(420,140);point22 = new Point(420,210);point23 = new Point(420,280);point24 = new Point(420,350);point25 = new Point(420,420);
		}
		
		//将各个点的坐标值存入网格数组aGrid
		private function makeGrid():void{
			
			//声明一个网格数组，用于存储棋盘上每个点的坐标值
			aGrid = new Array();
			
			//将棋盘上的各个点的坐标值加入数组aGrid
			aGrid.push(point01);aGrid.push(point02);aGrid.push(point03);aGrid.push(point04);aGrid.push(point05);
			aGrid.push(point06);aGrid.push(point07);aGrid.push(point08);aGrid.push(point09);aGrid.push(point10);
			aGrid.push(point11);aGrid.push(point12);aGrid.push(point13);aGrid.push(point14);aGrid.push(point15);
			aGrid.push(point16);aGrid.push(point17);aGrid.push(point18);aGrid.push(point19);aGrid.push(point20);
			aGrid.push(point21);aGrid.push(point22);aGrid.push(point23);aGrid.push(point24);aGrid.push(point25);
		}
		
		//设置图片的帧循环，因为是配对游戏，所以每种图案的帧序号要出现两次
		private function setUpPictures():void{
			for(var i:int = 0;i < numCircles*2; i++){
				if(i < numCircles){
					aPictures[i] = i+5;
				}else{
					aPictures[i] = i+5-numCircles;
				}
			}
		}
		private function clickCircleHandler(evt:MouseEvent):void
		{
			//evt.target.circleOpen();
			//trace("圆盘被单击啦");
			//trace("棋子"+evt.target.index+"被单击了，"+"它的图案编号是"+evt.target.pictureIndex);
			if(clicks == false)
			{
				evt.target.circleOpen();
				firstClick = evt.target.index;
				clicks = true;
			}
			else
			{
				if(evt.target.index != firstClick)
				{
					evt.target.circleOpen();
					secondClick = evt.target.index;
					if(evt.target.pictureIndex == aCircles[firstClick].pictureIndex)
					{
						//如果两幅图片匹配则使两幅图片逐渐消失
						//添加一个500毫秒的延迟，这样使图片消失时显得更自然一点
						aCircles[firstClick].removeEventListener(MouseEvent.CLICK,clickCircleHandler);
						evt.target.removeEventListener(MouseEvent.CLICK,clickCircleHandler);
						var disDelay:Timer = new Timer(500,1);
						disDelay.start();
						disDelay.addEventListener(TimerEvent.TIMER,Match);
						
						trace("匹配");
					}
					else
					{
						//如果两幅图片不同，则使两幅图片自动转回去
						//添加一个300毫秒的延迟，这样使图片转回去时显得更自然一点
						var delay:Timer = new Timer(300,1);
						delay.start();
						delay.addEventListener(TimerEvent.TIMER,noMatch);
						
						trace("不匹配");
					}
					//两次不同的单击结束之后，使单击状态置为可用状态
					clicks = false;
				}
			}
		}
		//两幅图片不匹配时使两幅图片自动转回去
		private function noMatch(evt:TimerEvent):void
		{
			aCircles[firstClick].circleClose();
			aCircles[secondClick].circleClose();
			
			//尝试次数累加并显示
			addTries();
		}
		//两幅图片相同时，使两幅图片逐渐的消失
		private function Match(evt:TimerEvent):void
		{
			//两棋子的标志是否已经删除，-1表示已经删除，1表示未被删除
			aCircles[secondClick].is_del = -1;
			aCircles[firstClick].is_del = -1;
			//使两棋子逐渐消失
			aCircles[secondClick].disappear();
			aCircles[firstClick].disappear();
			
			//aCircles.splice(secondClick,1);
			//aCircles.splice(firstClick,1);
			//container.removeChild(aCircles[secondClick]);
			//container.removeChild(aCircles[firstClick]);
			//尝试次数累加并显示
			addTries();
			//正确次数累加并显示
			addCorrects();
			
			//判断该关游戏是否结束，也就是correct == numCircles
			if(correct == numCircles)
			{
				//将游戏控制置为未开始状态
				this.is_startGame = false;
				trace(is_startGame);
				//是当前的机器人置为不显示状态
				this.aRobots[this.currentDirection - 1].visible = false;
				//使下一关按钮置为可用状态
				bNextState = true;
				bNext.visible = true;
				
				//显示闯关成功动画
				mWin.visible = true;
				mWin.play();
			}
		}
		private function addTries():void
		{
			//尝试次数累加并显示
			tries += 1;
			tTries.text = String(tries);
		}
		private function addCorrects():void
		{
			//正确次数累加并显示
			correct += 1;
			tCorrect.text = String(correct);
		}
	}
}