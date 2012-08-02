package com.dehats.fcg.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.air.file.FileUtils;
	import com.dehats.fcg.events.DragFileEvent;
	import com.dehats.fcg.model.ModelLocator;
	import com.dehats.fcg.view.AssetManager;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeDragOptions;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.geom.Point;

	public class DragFileOutCommand implements ICommand
	{

		public function execute(event:CairngormEvent):void
		{
			var evt:DragFileEvent = event as DragFileEvent;	
		
			var appModel:ModelLocator = ModelLocator.getInstance()
									
			var sourceFile:File = appModel.firstSelectedFile as File;//FileUtils.createTmpFileFromString(genFile.name+"."+genFile.extension, genFile.code);
			var fileIsDir:Boolean = sourceFile.isDirectory;
	        var clipboard:Clipboard = new Clipboard();
	        clipboard.setData(ClipboardFormats.FILE_LIST_FORMAT, appModel.selectedFiles, false); 
	        
	        if(!fileIsDir){
	        	var sourceCode:String = FileUtils.getFileString(sourceFile);
		        clipboard.setData(ClipboardFormats.TEXT_FORMAT, sourceCode,false);    	
	        }		
	        
	                              		        		    
			var options:NativeDragOptions = new NativeDragOptions();
			options.allowCopy = true;
			options.allowLink = false;
			options.allowMove = false;    		    
			
			var dragIcon:Class = AssetManager.page_copyIcon;
			
			var bmp:BitmapData = new BitmapData(16, 16, true, 0x00000000); 
			bmp.draw(new dragIcon().bitmapData as BitmapData);
		    
    		NativeDragManager.doDrag(evt.initiator, clipboard, bmp, new Point(-16,0), options);
    			
			
		}
		
	}
}