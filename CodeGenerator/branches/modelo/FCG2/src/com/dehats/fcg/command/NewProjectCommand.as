package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.model.ModelLocator;

	public class NewProjectCommand implements ICommand
	{

		public function execute(event:CairngormEvent):void
		{

			var appModel:ModelLocator = ModelLocator.getInstance();			
			
			appModel.appScreenIndex=appModel.SCREEN_SETUP;
			
		}
		
	}
}