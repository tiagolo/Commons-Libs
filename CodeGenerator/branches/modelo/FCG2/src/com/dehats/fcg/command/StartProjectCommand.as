package com.dehats.fcg.command
{
	import codegen.generation.*;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.events.FileSelectionEvent;
	import com.dehats.fcg.events.ProjectEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;

	public class StartProjectCommand extends FileCreatorCmdBase implements ICommand
	{
				
		public function execute(event:CairngormEvent):void
		{
			
			var projEvt:ProjectEvent = event as ProjectEvent;

			var appModel:ModelLocator = ModelLocator.getInstance();			

			// create main files directory
			appModel.generationFolder = File.createTempDirectory();			

			// initialize the IGenManager
			appModel.genManager = projEvt.genManager;
				
			appModel.genManager.init(projEvt.packageConfig);
			
			appModel.operationList = projEvt.operationList;
			
			// create the first files
			var files:Array = appModel.genManager.createBaseFiles();
			
			if(files && files.length>0)
			{
				var systemFiles:Array = createFileList(files);	
				new FileSelectionEvent(FileSelectionEvent.EVENT_FILESELECTION, [ systemFiles[0]]).dispatch();			
			} 

			// go to main screen
			appModel.appScreenIndex=appModel.SCREEN_MAIN;
			
		}
				
	}
}