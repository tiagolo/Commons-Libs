package com.dehats.fcg.events
{
	import flash.events.Event;

	/**
	 * 
	 * @author davidderaedt
	 * 
	 * Event dispacthed by generators when it has created one or more GeneratedFile Objects
	 * 
	 */

	public class FilesGeneratedEvent extends Event 
	{
		
		public static const EVENT_FILESGENERATED:String = "filesGenerated";
		
		public var generatedFiles:Array;
		
		public function FilesGeneratedEvent (pType:String, pArray:Array,  pBubbles:Boolean=false, pCancelable:Boolean=false ){
			
			generatedFiles=pArray;
			super(pType, pBubbles, pCancelable);
			
		}
		
		override public function clone():Event{
		
			return new FilesGeneratedEvent(type,  generatedFiles,  bubbles, cancelable);
			
		}

		
	}

}