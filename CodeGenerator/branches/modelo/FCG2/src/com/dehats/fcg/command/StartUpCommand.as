package com.dehats.fcg.command
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import codegen.generation.TemplateManager;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;

	public class StartUpCommand implements ICommand
	{

		private var updater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function execute(event:CairngormEvent):void
		{
			var appModel:ModelLocator = ModelLocator.getInstance();
			
			//var updateManager:UpdateManager = new UpdateManager(appModel.APP_UPDATE_XML_URL, appModel.AIR_FILE);
			
            updater.configurationFile = new File("app:/updaterConfig.xml");
            updater.addEventListener(UpdateEvent.INITIALIZED, updaterInitialized);
            updater.initialize();			
			
			// get templates
			
			 var dir2:File = getOrMoveFile(appModel.TEMPLATES_DIR);
			TemplateManager.getInstance().getTemplateString = getTemplateString;
			TemplateManager.getInstance().getTemplates(appModel.TEMPLATES_DIR);
			
		}


        private function updaterInitialized(event:UpdateEvent):void
        {
            updater.checkNow();
        }

		private function getOrMoveFile(pDirPath:String):File
		{
			
			var f:File = File.applicationStorageDirectory.resolvePath(pDirPath);
			
			if(!f.exists) { 
				
				trace("Unable to find "+pDirPath+", copying from applicationDirectory to applicationStorageDirectory");
				
				var f2:File = File.applicationDirectory.resolvePath(pDirPath); 
				
				if( ! f2.exists ) Alert.show("Unable to find file or directory : "+ pDirPath, "File not found");
				
				f2.copyTo(File.applicationStorageDirectory.resolvePath(pDirPath));
				 
				return f2;
			}
			else return f;
			
		}



		private function getTemplateString(pDirPath:String, pFileName:String):String
		{
			return getFileString(getTemplate(pDirPath+pFileName));	
		}
		
		private function getTemplate(pPath:String):File
		{
			var f:File = File.applicationStorageDirectory.resolvePath(pPath);
			
			if(!f.exists) { 
				Alert.show("Unable to find template "+f.nativePath, "ERROR");
				return new File();
			}
			
			return f;
		}
		
		
		public static function getFileString(file:File, pEncoding:String="utf-8"):String
		{
			
			var stream:FileStream = new FileStream();
			
			stream.open(file, FileMode.READ);
			
			var str:String = stream.readMultiByte(stream.bytesAvailable, pEncoding);
			
			stream.close();
			
			return str;
		}	
		
	}
}