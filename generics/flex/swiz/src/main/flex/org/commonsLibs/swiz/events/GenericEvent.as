package org.commonsLibs.swiz.events
{
	import flash.events.Event;

	public class GenericEvent extends Event
	{

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		public static const EDIT_STATE:String = "edit";

		public static const LIST_STATE:String = "list";

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function GenericEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		//--------------------------------------
		//   Property 
		//--------------------------------------

		public var data:Object;
		
		public var currentState:String;
		
		public var property:String;

		public var isPaged:Boolean;

		public var message:String;

		public var properties:Array;

		public var validators:Array;

	}
}
