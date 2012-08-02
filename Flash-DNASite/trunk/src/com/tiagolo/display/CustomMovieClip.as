package com.tiagolo.display
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class CustomMovieClip extends MovieClip
	{	
		public function CustomMovieClip()
		{
			super();
		}
		
		override public function set width(value:Number):void
		{
			updateDisplayList(value,height);
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set height(value:Number):void
		{
			updateDisplayList(width,value);
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		public function updateDisplayList(uWidth:Number,uHeight:Number):void
		{
			super.width = uWidth;
			super.height = uHeight;
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
	}
}