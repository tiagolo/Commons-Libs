package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.events.FileDeletionEvent;
	import com.dehats.fcg.events.FileSelectionEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;

	public class DeleteFilesCommand implements ICommand
	{

		public function execute(event:CairngormEvent):void
		{
			var evt:FileDeletionEvent = event as FileDeletionEvent;
			
			var appModel:ModelLocator = ModelLocator.getInstance();
			
			for ( var i:int = 0 ;  i < evt.files.length ; i ++)
			{
				var f:File = evt.files[i];
				f.deleteFile();
			}

			new FileSelectionEvent(FileSelectionEvent.EVENT_FILESELECTION, []).dispatch();
			
		}
		
	}
}