package com.tiagolo.utils
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class LoadingCircle extends Sprite
	{
		private var numCircles:Number;
		private var centerX:Number;
		private var centerY:Number;
		private var radius:Number;
		private var angle:Number;
		private var radians:Number;
		private var count:Number;
		private var rotationSpeed:Number
		
		public function LoadingCircle(color:Number = 0x999999,speed:Number = 6, numCircles:Number = 10, centerX:Number = -2, centerY:Number = -2, radius:Number = 10)
		{
			super();
			
			this.rotationSpeed = speed;
			this.numCircles = numCircles;
			this.centerX = centerX;
			this.centerY = centerY;
			this.radius = radius;
			this.angle = numCircles/180;
			this.radians = (360/numCircles)*Math.PI/180;
			this.count = 1;
			
			for (var i:Number = 0; i < numCircles; i++) {
				var mc:Sprite = new Sprite();
				mc.name = "circle" + i;
			    drawCircle(mc, 2, color, 1);
			    mc.x = centerX+Math.sin(radians*i)*radius;
			    mc.y = centerY+Math.cos(radians*i)*radius;
			    mc.alpha = i*(1/numCircles);
			    addChild(mc);
			}
			
			this.addEventListener(Event.ENTER_FRAME, frameHandler);
 		}
		
		private function frameHandler(event:Event):void
		{
			this.rotation -= rotationSpeed;
			
		}
		
		private function drawCircle(target_mc:Sprite, radius:Number, fillColor:Number, fillAlpha:Number):void {
		    var x:Number = radius;
		    var y:Number = radius;
		        target_mc.graphics.beginFill(fillColor, fillAlpha);
		        target_mc.graphics.moveTo(x+radius, y);
		        target_mc.graphics.curveTo(radius+x, Math.tan(Math.PI/8)*radius+y, Math.sin(Math.PI/4)*radius+x, Math.sin(Math.PI/4)*radius+y);
		        target_mc.graphics.curveTo(Math.tan(Math.PI/8)*radius+x, radius+y, x, radius+y);
		        target_mc.graphics.curveTo(-Math.tan(Math.PI/8)*radius+x, radius+y, -Math.sin(Math.PI/4)*radius+x, Math.sin(Math.PI/4)*radius+y);
		        target_mc.graphics.curveTo(-radius+x, Math.tan(Math.PI/8)*radius+y, -radius+x, y);
		        target_mc.graphics.curveTo(-radius+x, -Math.tan(Math.PI/8)*radius+y, -Math.sin(Math.PI/4)*radius+x, -Math.sin(Math.PI/4)*radius+y);
		        target_mc.graphics.curveTo(-Math.tan(Math.PI/8)*radius+x, -radius+y, x, -radius+y);
		        target_mc.graphics.curveTo(Math.tan(Math.PI/8)*radius+x, -radius+y, Math.sin(Math.PI/4)*radius+x, -Math.sin(Math.PI/4)*radius+y);
		        target_mc.graphics.curveTo(radius+x, -Math.tan(Math.PI/8)*radius+y, radius+x, y);
		        target_mc.graphics.endFill();
		}
	}
}