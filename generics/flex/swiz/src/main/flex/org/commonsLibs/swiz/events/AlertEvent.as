package org.commonsLibs.swiz.events
{
	import flash.events.Event;

	public class AlertEvent extends Event
	{

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		public static const CONFIRM:String = "AlertEvent.CONFIRM";

		public static const ERROR:String = "AlertEvent.ERROR";

		public static const INFO:String = "AlertEvent.INFO";

		public static const SELECTION_ERROR:String = "AlertEvent.SELECTION_ERROR";

		public static const SUCCESS:String = "AlertEvent.SUCCESS";

		//--------------------------------------
		//   Property 
		//--------------------------------------

		public var closeHandler:Function;

		public var mensagem:String;

		public var titulo:String;

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function AlertEvent(type:String, mensagem:String = null, titulo:String = null, closeHandler:Function = null, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			this.mensagem = mensagem;
			this.titulo = titulo;
			this.closeHandler = closeHandler;

			super(type, bubbles, cancelable);
		}
	}
}
