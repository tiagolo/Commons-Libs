package org.commonsLibs.swiz.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

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
		
		private var _dispatcher:IEventDispatcher;
		
		public function get dispatcher():IEventDispatcher
		{
			if(!_dispatcher && currentTarget && currentTarget is IEventDispatcher)
			{
				_dispatcher = currentTarget as IEventDispatcher;
			}
			
			return _dispatcher;
		}
		
		public function set dispatcher(value:IEventDispatcher):void {
			_dispatcher = value;
		}

	}
}
