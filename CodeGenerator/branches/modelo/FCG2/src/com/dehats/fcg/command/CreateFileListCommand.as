package com.dehats.fcg.command
{
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.events.CreateFileListEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class CreateFileListCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{
			
			var createEvt:CreateFileListEvent = event as CreateFileListEvent;
			
			var appModel:ModelLocator = ModelLocator.getInstance();

			var n:int = createFileList(createEvt.destinationDir, createEvt.list);	

			Alert.show(n+" files successfully created.", "File creation report", Alert.OK);
			
		}


		public function createFileList(pDest:File, pList:ArrayCollection):int
		{
			var n:int = 0;
			for ( var a:int = 0 ; a < pList.length ; a++)
			{
				var f:File = pList.getItemAt(a) as File;
				if(f.isDirectory)
				{
					n += createFileList(pDest.resolvePath(f.name),new ArrayCollection(f.getDirectoryListing()));
				}
				else
				{
					f.moveTo(pDest.resolvePath(f.name), true);
					n++;
				}
			}
						
			return n;
			
		}
		
	}
}