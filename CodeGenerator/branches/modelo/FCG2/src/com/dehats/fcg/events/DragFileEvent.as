package com.dehats.fcg.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;

	public class DragFileEvent extends CairngormEvent
	{
		
		public static const EVENT_START_DRAG_OUT :String="startDragOut";
		
		public var initiator:InteractiveObject;
		
		public function DragFileEvent(type:String, pInitiator:InteractiveObject, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			initiator = pInitiator;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new DragFileEvent( type, initiator, bubbles, cancelable);
		}
		
	}
}