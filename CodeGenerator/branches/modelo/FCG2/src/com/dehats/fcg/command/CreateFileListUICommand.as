package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.events.CreateFileListEvent;
	import com.dehats.fcg.events.CreateFileListUIEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public class CreateFileListUICommand implements ICommand
	{

		private var collecToPublish:ArrayCollection;
		private var appModel:ModelLocator = ModelLocator.getInstance();

		public function execute(event:CairngormEvent):void
		{
			var evt:CreateFileListUIEvent = event as CreateFileListUIEvent;
			
			collecToPublish = new ArrayCollection(evt.fileList) ;
			
			var f:File = new File();			
			f.addEventListener(Event.SELECT, onDirSelected);									
			f.browseForDirectory("Select a destination");
			
		}
		
		private function onDirSelected(pEvt:Event):void
		{
			var destinationDir:File = (pEvt.target as File);
			
			if(collecToPublish.length>0)
			{
				new CreateFileListEvent(CreateFileListEvent.EVENT_CREATE_LIST, collecToPublish,destinationDir).dispatch();				
			}
			else{
				var col:ArrayCollection = new ArrayCollection (appModel.generationFolder.getDirectoryListing());
				new CreateFileListEvent(CreateFileListEvent.EVENT_CREATE_LIST, col, destinationDir).dispatch();									
			}								
		}

		
	}
}