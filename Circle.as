package{
	import flash.display.MovieClip;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	
	public class Circle extends MovieClip{
		public var index:int;
		public var pictureIndex:int;
		//判断是否已经删除，删除值为-1，没删除值为1
		public var is_del:int;
		
		public function Circle(i:int):void{
			this.index = i;
			is_del = 1;
		}
		//当单击棋子时模拟棋子翻转效果，并使其显示出它所代表的图案
		public function circleOpen():void
		{
			var openTween:Tween = new Tween(this,"scaleX",Regular.easeIn,1,0,0.2,true);
			openTween.addEventListener(TweenEvent.MOTION_FINISH,finishOpen);
		}
		private function finishOpen(evt:TweenEvent):void
		{
			this.gotoAndStop(this.pictureIndex);
			var openFinishTween:Tween = new Tween(this,"scaleX",Regular.easeIn,0,1,0.2,true);
		}
		//当打开的两个棋子不同时，两个棋子自动转回去
		public function circleClose():void
		{
			var closeTween:Tween = new Tween(this,"scaleX",Regular.easeIn,1,0,0.2,true);
			closeTween.addEventListener(TweenEvent.MOTION_FINISH,finishClose);
		}
		private function finishClose(evt:TweenEvent):void
		{
			this.gotoAndStop(1);
			var closeFinishTween:Tween = new Tween(this,"scaleX",Regular.easeIn,0,1,0.2,true);
		}
		//当两个棋子相同时，使两个棋子逐渐的消失
		public function disappear():void
		{
			var disappearTween:Tween = new Tween(this,"alpha",Regular.easeIn,1,0,0.1,true);
			var disappearXTween:Tween = new Tween(this,"scaleX",Regular.easeIn,1,0,0.1,true);
			var disappearYTween:Tween = new Tween(this,"scaleY",Regular.easeIn,1,0,0.1,true);
		}
	}
}