package br.pro.tiagolopes.events
{
	import flash.events.Event;
	
	public class GenericEvent extends Event
	{
		public static const LIST_STATE:String = "list";
		public static const EDIT_STATE:String = "edit";
		
		public var currentState:String;
		public var message:String;
		public var properties:Array;
		public var validators:Array;
		
		public function GenericEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}