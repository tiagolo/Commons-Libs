package com.dehats.fcg.model
{
	import codegen.generation.IGenManager;
	
	import com.adobe.cairngorm.model.IModelLocator;
	
	import flash.filesystem.File;
	
	[Bindable]
	public class ModelLocator implements IModelLocator
	{
		
		private static var instance:ModelLocator;

		public const APP_UPDATE_XML_URL:String = "http://www.dehats.com/projets/fcg/version.xml?"+new Date().getTime();
		public const AIR_FILE:String = "FCG.air";
		
		/*
			Warning : templates update mechanism
			To make sure the new templates are embedded with the next release, and
			do not overwrite the user's files, do the following :
			1. Modify the templates in the src directory
			2. Rename the template directory (it is then copied to the bin directory)
			3. Modify the pDirPath parameter when getTemplates(pDirPath) is called to match the new name
			
			This way, the new templates are added to the user's app preference directory with
			the next update, and the app uses them. The previous templates stay in this
			preference directory, so that the user may use them as a reference to modify
			the new templates.
			
		*/		
		
		public const TEMPLATES_DIR:String = "FCGTemplates_v097000/";

		public var appScreenIndex:int=0;
		public const SCREEN_SETUP:int=0;
		public const SCREEN_MAIN:int=1;


		public var operationList:Array;
		public var genManager:IGenManager;

		public var generationFolder:File;		
		public var selectedFiles:Array=[];
		public var firstSelectedFile:File;
		public var selectedFileCode:String="";

		
		public static function getInstance():ModelLocator
		{
			if(instance==null) instance = new ModelLocator();
			return instance;
		}
		
	}
}