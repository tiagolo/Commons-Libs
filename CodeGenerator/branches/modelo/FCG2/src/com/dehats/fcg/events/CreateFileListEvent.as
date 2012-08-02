package com.dehats.fcg.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	

	public class CreateFileListEvent extends CairngormEvent
	{
		
		public static const EVENT_CREATE_LIST:String="createFileList";
			
		public var list:ArrayCollection;
		public var destinationDir:File;
		
		public function CreateFileListEvent(pType:String, pList:ArrayCollection, pDir:File)
		{
			list = pList;
			destinationDir=pDir
			super(pType);
		}
		
		
		override public function clone():Event
		{
			return new CreateFileListEvent(type, list, destinationDir);
		}
		
		
	}
}