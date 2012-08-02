package com.tiagolo.controls.grid
{
	import flash.events.Event;
		
	public class GridEvent extends Event
	{
		public static const ITEM_DOUBLECLICK:String = "itemDoubleClick";
		
		public var item:Object;
		
		public function GridEvent(type:String, item:Object)
		{
			super(type, false, false);
			this.item = item;
		}
	}
}