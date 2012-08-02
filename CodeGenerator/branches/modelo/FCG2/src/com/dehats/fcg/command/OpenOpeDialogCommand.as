package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.events.FileSelectionEvent;
	import com.dehats.fcg.events.FilesGeneratedEvent;
	import com.dehats.fcg.events.OpenOpeDialogEvent;
	import com.dehats.fcg.model.ModelLocator;
	import com.dehats.fcg.view.OperationDialog;
	import com.dehats.fcg.view.OperationDialogLoader;
	
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;

	public class OpenOpeDialogCommand extends FileCreatorCmdBase implements ICommand
	{

		private var dialog:OperationDialogLoader;

		public function execute(event:CairngormEvent):void
		{

			var evt:OpenOpeDialogEvent = event as OpenOpeDialogEvent;
 
			var appModel:ModelLocator = ModelLocator.getInstance();

			dialog =  PopUpManager.createPopUp(Application.application as DisplayObject, OperationDialogLoader, true) as OperationDialogLoader;												
			PopUpManager.centerPopUp(dialog);

			var dialogClass:Class = evt.dialogClass;
			var opeDialog:OperationDialog = new dialogClass();			
			opeDialog.genManager = appModel.genManager;
			opeDialog.addEventListener(FilesGeneratedEvent.EVENT_FILESGENERATED, onFilesGenerated);

			dialog.operationDialog = opeDialog;
			dialog.title = evt.name;
			
		}

		private function onFilesGenerated(pEvt:FilesGeneratedEvent):void
		{
			pEvt.target.removeEventListener(FilesGeneratedEvent.EVENT_FILESGENERATED, onFilesGenerated);
			
			var systemFiles:Array = createFileList(pEvt.generatedFiles);
			
			new FileSelectionEvent(FileSelectionEvent.EVENT_FILESELECTION, systemFiles).dispatch();		
						
			PopUpManager.removePopUp(dialog);	
		}
		
		
	}
}