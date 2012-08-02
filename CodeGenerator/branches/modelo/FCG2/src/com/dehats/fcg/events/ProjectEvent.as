package com.dehats.fcg.events
{
	import codegen.generation.IGenManager;
	import codegen.generation.PackageConfig;
	
	import com.adobe.cairngorm.control.CairngormEvent;
		
	import flash.events.Event;

	public class ProjectEvent extends CairngormEvent
	{
		
		static public const EVENT_PROJECT_START:String = "startProject";
		
		
		public var packageConfig:PackageConfig;		
		public var operationList:Array;				
		public var genManager:IGenManager
		
		public function ProjectEvent(pType:String, manager:IGenManager, opeList:Array, pCairngormConfig:PackageConfig)
		{
			genManager = manager;
			operationList = opeList ;
			packageConfig = pCairngormConfig;
			super(pType);
		}

		override public function clone():Event
		{
			return new ProjectEvent(type, genManager, operationList, packageConfig);
		}
		
	}
}