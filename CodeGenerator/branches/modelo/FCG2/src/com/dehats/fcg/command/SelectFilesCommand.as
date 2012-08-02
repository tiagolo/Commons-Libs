package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.air.file.FileUtils;
	import com.dehats.fcg.events.FileSelectionEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;

	public class SelectFilesCommand implements ICommand
	{

		public function execute(event:CairngormEvent):void
		{
	
			var appModel:ModelLocator = ModelLocator.getInstance();
			
			var evt:FileSelectionEvent = event as FileSelectionEvent;
			
			appModel.selectedFiles = evt.fileList;			
			appModel.firstSelectedFile = evt.fileList[0] as File ;
			
			if(appModel.firstSelectedFile==null ||  appModel.firstSelectedFile.isDirectory) return ;
			
			appModel.selectedFileCode = FileUtils.getFileString(appModel.firstSelectedFile);		
		}
		 
	}
}