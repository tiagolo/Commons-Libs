package org.commonsLibs.swiz.business
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.events.UncaughtErrorEvents;
	
	import mx.controls.Alert;
	import mx.managers.SystemManager;

	public class AlertManager
	{

		public static function faultHandler(event:Event):void
		{

		}

		private var _isUncaughtErrorEnabled:Boolean;

		//--------------------------------------
		//   Function 
		//--------------------------------------

		public function get isUncaughtErrorEnabled():Boolean
		{
			return _isUncaughtErrorEnabled;
		}

		public function set isUncaughtErrorEnabled(value:Boolean):void
		{
			_isUncaughtErrorEnabled = value;

			var uncaughtErrorEvents:UncaughtErrorEvents = SystemManager.getSWFRoot(this).loaderInfo.uncaughtErrorEvents;

			if (_isUncaughtErrorEnabled)
			{
				uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			}
			else if (uncaughtErrorEvents.hasEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR))
			{
				uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			}
		}

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function AlertManager()
		{
			Alert.yesLabel = "Sim";
			Alert.noLabel = "Não";
		}

		[EventHandler(event = "AlertEvent.CONFIRM", properties = "mensagem,titulo,closeHandler")]
		public function showConfirmaAlert(mensagem:String, titulo:String, closeHandler:Function):void
		{
			showAlert(mensagem, titulo, Alert.YES | Alert.NO, null, closeHandler);
		}

		[EventHandler(event = "AlertEvent.ERROR", properties = "mensagem")]
		public function showError(mensagem:String):void
		{
			showAlert(mensagem, "Mensagem");
		}

		[EventHandler(event = "AlertEvent.SELECTION_ERROR")]
		public function showSelectionAlert():void
		{
			showAlert("Por favor selecione um item para efetuar esta ação", "Mensagem");
		}

		[EventHandler(event = "AlertEvent.SUCCESS", properties="closeHandler")]
		public function showSuccess(closeHandler:Function = null):void
		{
			showAlert("Operação realizada com sucesso", "Sucesso",Alert.OK,null,closeHandler);
		}

		public function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			event.preventDefault();

			showAlert(event.error.message, event.error.name);
		}

		protected function showAlert(text:String = "", title:String = "", flags:uint = 0x4 /* Alert.OK */, parent:Sprite = null, closeHandler:Function = null, iconClass:Class = null, defaultButtonFlag:uint = 0x4 /* Alert.OK */):Alert
		{
			var alert:Alert = Alert.show(text, title, flags, parent, closeHandler, iconClass, defaultButtonFlag);
			return alert;
		}
	}
}
