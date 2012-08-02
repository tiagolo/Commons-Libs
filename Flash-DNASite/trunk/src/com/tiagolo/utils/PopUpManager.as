package com.tiagolo.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	public class PopUpManager
	{
		private static var instance:PopUpManager;
		private static var popup:DisplayObject;
		
		{
			if(!instance) instance = new PopUpManager();
		}
		
		public function PopUpManager()
		{
			if(instance)
				throw new Error("You shouldn't use the new operator!");
		}
		
		public static function addPopup(obj:DisplayObject,target:DisplayObjectContainer):void
		{
			if(!popup){
				popup = obj;
				DisplayObjectContainer(target).addChild(obj);
			}
			else
			{
				trace("Error::Já existe um popup adicionado na tela");
			}
		}
		
		public static function removePopup(obj:DisplayObject):void
		{
			if(popup == obj){
				obj.parent.removeChild(obj);
				popup = null;
			}
			else
			{
				trace("Error::O objeto não é o popup atual");
			}
		}
	}
}