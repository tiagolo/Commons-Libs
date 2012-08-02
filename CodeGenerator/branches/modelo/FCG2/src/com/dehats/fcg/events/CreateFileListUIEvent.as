package com.dehats.fcg.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import Array;


	public class CreateFileListUIEvent extends CairngormEvent
	{
		
		public static const EVENT_CREATEFILELISTUI:String = "CreateFileListUI";
		
		public var fileList:Array;
		
		public function CreateFileListUIEvent (pType:String, pList:Array=null,  pBubbles:Boolean=false, pCancelable:Boolean=false ){
			
			fileList=pList;
			super(pType, pBubbles, pCancelable);
			
		}
		
		override public function clone():Event{
		
			return new CreateFileListUIEvent(type,  fileList,  bubbles, cancelable);
			
		}

		
	}

}