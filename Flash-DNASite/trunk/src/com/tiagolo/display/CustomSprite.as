package com.tiagolo.display
{
	import flash.display.Sprite;

	public class CustomSprite extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		protected var scaleContent:Boolean;
		
		public function CustomSprite()
		{
			super();
		}
		
		override public function set width(value:Number):void
		{
			updateDisplayList(value,height);
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(value:Number):void
		{
			updateDisplayList(width,value);
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		public function updateDisplayList(uWidth:Number,uHeight:Number):void
		{
			_width = uWidth;
			_height = uHeight;
			refreshDisplay();
		}
		
		public function refresh():void
		{
			for(var i:int; i < numChildren; i++)
			{
				if(getChildAt(i) is CustomSprite)
				{
					CustomSprite(getChildAt(i)).refresh()
				}
				else 
				if(getChildAt(i) is CustomMovieClip)
				{
					CustomMovieClip(getChildAt(i)).refresh()
				}
			}
		}
		
		private function refreshDisplay():void
		{
			if(scaleContent)
			{
				super.width = _width;
				super.height = _height;
			}
		}
	}
}