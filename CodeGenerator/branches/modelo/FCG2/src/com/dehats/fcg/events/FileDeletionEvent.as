package com.dehats.fcg.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;


	public class FileDeletionEvent extends CairngormEvent
	{
		
		public static const EVENT_FILEDELETION:String = "fileDeletion";
		
		public var files:Array;
		
		public function FileDeletionEvent (pType:String, pArray:Array,  pBubbles:Boolean=false, pCancelable:Boolean=false ){
			
			files=pArray;
			super(pType, pBubbles, pCancelable);
			
		}
		
		override public function clone():Event{
		
			return new FileDeletionEvent(type,  files,  bubbles, cancelable);
			
		}

		
	}

}