package com.app.events
{
	import com.app.model.Familia;
	
	import flash.events.Event;
	
	import org.commonsLibs.swiz.events.GenericEvent;
	
	public class FamiliaEvent extends GenericEvent
	{
		public static const FIND_ALL:String		= "FamiliaEvent.FIND_ALL";
		public static const FIND_BY_ID:String	= "FamiliaEvent.FIND_BY_ID";
		public static const SAVE:String			= "FamiliaEvent.SAVE";
		public static const REMOVE:String		= "FamiliaEvent.REMOVE";
		public static const EDIT:String			= "FamiliaEvent.EDIT";
		public static const CANCEL:String = "FamiliaEvent.CANCEL";
		
		public var familia:Familia;
		
		public function FamiliaEvent (pType:String,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(pType,bubbles,cancelable);
		}
		
		override public function clone():Event
		{
			var event:FamiliaEvent = new FamiliaEvent(type,bubbles,cancelable);
			event.familia = familia;
			return event;
		}
	}
}