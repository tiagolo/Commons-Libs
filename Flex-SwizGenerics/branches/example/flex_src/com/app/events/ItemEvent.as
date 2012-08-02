package com.app.events
{
	import com.app.model.Item;
	
	import flash.events.Event;
	
	import org.commonsLibs.swiz.events.GenericEvent;
	
	public class ItemEvent extends GenericEvent
	{
		public static const FIND_ALL:String		= "ItemEvent.FIND_ALL";
		public static const FIND_BY_ID:String	= "ItemEvent.FIND_BY_ID";
		public static const SAVE:String			= "ItemEvent.SAVE";
		public static const REMOVE:String		= "ItemEvent.REMOVE";
		public static const EDIT:String			= "ItemEvent.EDIT";
		public static const CANCEL:String		= "ItemEvent.CANCEL";
		public static const FIND_AUDIT:String	= "ItemEvent.FIND_AUDIT";
		
		[Bindable]
		public var item:Item;
		
		public function ItemEvent (pType:String,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(pType,bubbles,cancelable);
		}
		
		override public function clone():Event
		{
			var event:ItemEvent = new ItemEvent(type,bubbles,cancelable);
			event.item = item;
			return event;
		}
	}
}