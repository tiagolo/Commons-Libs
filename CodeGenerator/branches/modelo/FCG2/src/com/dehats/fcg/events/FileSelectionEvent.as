package com.dehats.fcg.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;


	public class FileSelectionEvent extends CairngormEvent
	{
		
		public static const EVENT_FILESELECTION:String = "fileSelection";
		
		public var fileList:Array;
		
		public function FileSelectionEvent (pType:String, pList:Array,  pBubbles:Boolean=false, pCancelable:Boolean=false ){
			
			fileList=pList;
			super(pType, pBubbles, pCancelable);
			
		}
		
		override public function clone():Event{
		
			return new FileSelectionEvent(type,  fileList,  bubbles, cancelable);
			
		}

		
	}

}