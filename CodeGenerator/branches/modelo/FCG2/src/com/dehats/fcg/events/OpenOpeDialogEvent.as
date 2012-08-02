package com.dehats.fcg.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;


	public class OpenOpeDialogEvent extends CairngormEvent
	{
		
		public static const EVENT_OPENOPEDIALOG:String = "OpenOpeDialog";

		public var name:String;		
		public var dialogClass:Class;
		
		public function OpenOpeDialogEvent (pType:String, pName:String, pDialogClass:Class, pBubbles:Boolean=false, pCancelable:Boolean=false ){
			
			dialogClass = pDialogClass;
			name = pName;
			super(pType, pBubbles, pCancelable);
			
		}
		
		override public function clone():Event{
		
			return new OpenOpeDialogEvent(type, name, dialogClass, bubbles, cancelable);
			
		}

		
	}

}