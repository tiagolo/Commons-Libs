package br.pro.tiagolopes.events
{
	import flash.events.Event;

	public class AlertEvent extends Event
	{
		public static const SUCCESS:String = "ALERT_success";
		public static const SELECTION_ERROR:String = "ALERT_selectionError";
		public static const ERROR:String = "ALERT_error";
		public static const CONFIRM:String = "ALERT_confirm";
		
		public var mensagem:String;
		public var titulo:String;
		public var closeHandler:Function;
		
		public function AlertEvent(type:String, 
								   mensagem:String = null, titulo:String = null, 
								   closeHandler:Function = null,
								   bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.mensagem = mensagem;
			this.titulo = titulo;
			this.closeHandler = closeHandler;
			
			super(type, bubbles, cancelable);
		}
	}
}