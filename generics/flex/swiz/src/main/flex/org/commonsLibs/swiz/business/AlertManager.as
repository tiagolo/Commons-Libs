package org.commonsLibs.swiz.business
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.UncaughtErrorEvent;
	import flash.events.UncaughtErrorEvents;
	import flash.system.System;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.FlexLoader;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.messaging.FlexClient;

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

		[Mediate(event = "AlertEvent.CONFIRM", properties = "mensagem,titulo,closeHandler")]
		public function showConfirmaAlert(mensagem:String, titulo:String, closeHandler:Function):void
		{
			showAlert(mensagem, titulo, Alert.YES | Alert.NO, null, closeHandler
		}

		[Mediate(event = "AlertEvent.ERROR", properties = "mensagem")]
		public function showError(mensagem:String):void
		{
			showAlert(mensagem, "Mensagem");
		}

		[Mediate(event = "AlertEvent.SELECTION_ERROR")]
		public function showSelectionAlert():void
		{
			showAlert("Por favor selecione um item para efetuar esta ação", "Mensagem");
		}

		[Mediate(event = "AlertEvent.SUCCESS")]
		public function showSuccess():void
		{
			showAlert("Operação realizada com sucesso", "Sucesso")
		}

		public function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			event.preventDefault();

			showAlert(event.error.message, event.error.name);
		}

		protected function showAlert(text:String = "", title:String = "", flags:uint = 0x4 /* Alert.OK */, parent:Sprite = null, closeHandler:Function = null, iconClass:Class = null, defaultButtonFlag:uint = 0x4 /* Alert.OK */):Alert
		{
			return Alert.show(text, title, flags, parent, closeHandler, iconClass, defaultButtonFlag);
		}
	}
}
