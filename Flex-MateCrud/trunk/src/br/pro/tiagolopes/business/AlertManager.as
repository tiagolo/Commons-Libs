package br.pro.tiagolopes.business
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	
	public class AlertManager
	{
		public function AlertManager()
		{
			Alert.yesLabel = "Sim";
			Alert.noLabel = "Não";
		}
		
		public function showConfirmaAlert(mensagem:String,titulo:String,closeHandler:Function):void
		{
			showAlert(mensagem,titulo,Alert.YES | Alert.NO,null,closeHandler);
		}
		
		public function showSelectionAlert():void
		{
			showAlert("Por favor selecione um item para efetuar esta ação","Mensagem");
		}
		
		public function showError(mensagem:String):void
		{
			showAlert(mensagem,"Mensagem");
		}
		
		public function showSuccess():void
		{
			showAlert("Operação realizada com sucesso","Sucesso")
		}
		
		private function showAlert(text:String = "", title:String = "",
								   flags:uint = 0x4 /* Alert.OK */, 
								   parent:Sprite = null, 
								   closeHandler:Function = null, 
								   iconClass:Class = null, 
								   defaultButtonFlag:uint = 0x4 /* Alert.OK */):Alert
		{
			return Alert.show(text, title, flags, parent, closeHandler,	iconClass, defaultButtonFlag);
		}
	}
}