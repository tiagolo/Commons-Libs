package com.tiagolo.list.events
{
	import com.tiagolo.list.BaseListRender;
	
	import flash.events.Event;

	public class ListEvent extends Event
	{
		public static const ITEM_CLICK:String = "itemClick";
		
		public var item:BaseListRender;
		
		public function ListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}