package codegen.generation
{
	import codegen.analysis.PseudoClass;
	import codegen.analysis.RemoteService;
	
	import mx.collections.ArrayCollection;

	public class TiagoloGenManager implements IGenManager
	{
		public var remoteServicesCollec:ArrayCollection = new ArrayCollection();
		
		public var viewCollec:ArrayCollection = new ArrayCollection();		
		
		public var daoCollec:ArrayCollection = new ArrayCollection();
		public var serviceCollec:ArrayCollection = new ArrayCollection();
		public var managerCollec:ArrayCollection = new ArrayCollection();
		public var eventCollec:ArrayCollection = new ArrayCollection();
		public var uiCollec:ArrayCollection = new ArrayCollection();
		
		public var voCollec:ArrayCollection = new ArrayCollection();
		
		public var mainEventMap:GeneratedFile; 
		public var modelMap:GeneratedFile; 
		
		protected var generator:TiagoloGenerator;
		
		[Bindable]
		public var as3_types:Array = ["Object", "Array", "Number", "int", "uint", "Boolean", "String", "XML", "Date"];
		
		
		public function init(pConfig:PackageConfig):void
		{
			generator = new TiagoloGenerator(pConfig);			
		}
		
		public function createBaseFiles():Array
		{
			var list:Array =[];
			
			mainEventMap = generator.generateMainEventMap(voCollec);
			modelMap = generator.generateModelMap(voCollec);
			list.push(mainEventMap,modelMap);
			
			return list;
		}
		
		protected function updateMainView():void
		{
			var genMainEvenMapFile:GeneratedFile = generator.generateMainEventMap(voCollec);
			var genModelMapFile:GeneratedFile = generator.generateModelMap(voCollec);
			mainEventMap.code = genMainEvenMapFile.code;
			modelMap.code = genModelMapFile.code;
		}
		
		public function addVO(pClassFile:PseudoClass, pAddManager:Boolean, pAddDao:Boolean, pAddService:Boolean, 
							  pAddEvent:Boolean, pAddUI:Boolean, pTargetName:String=null):Array
		{
			var gFileList:Array = [];
			
			var voGFile:GeneratedFile = generator.generateVO(pClassFile, pTargetName);
			voCollec.addItem(voGFile);
			gFileList.push(voGFile);
			
			
			if(pAddDao) {
				var daoFile:GeneratedFile = generator.generateVODao(voGFile);			
				daoCollec.addItem(daoFile);
				gFileList.push(daoFile);
				
				var daoHibernateFile:GeneratedFile = generator.generateVODaoHibernate(voGFile);			
				daoCollec.addItem(daoHibernateFile);
				gFileList.push(daoHibernateFile);
			}
			if(pAddService) {
				var serviceFile:GeneratedFile = generator.generateVOService(voGFile);			
				serviceCollec.addItem(serviceFile);
				gFileList.push(serviceFile);
				
				var serviceImplFile:GeneratedFile = generator.generateVOServiceImpl(voGFile);			
				serviceCollec.addItem(serviceImplFile);
				gFileList.push(serviceImplFile);
			}
			if(pAddManager)
			{
				var managerFile:GeneratedFile = generator.generateVOManager(voGFile);			
				managerCollec.addItem(managerFile);
				gFileList.push(managerFile);				
			}
			if(pAddEvent)
			{
				var eventFile:GeneratedFile = generator.generateVOEvent(voGFile);
				eventCollec.addItem(eventFile);
				gFileList.push(eventFile);
			}
			if(pAddUI)
			{
				var viewFile:GeneratedFile = generator.generateUIView(voGFile);
				var listFile:GeneratedFile = generator.generateUIList(voGFile);
				var editFile:GeneratedFile = generator.generateUIEdit(voGFile);
				uiCollec.addAll(new ArrayCollection([viewFile,listFile,editFile]));
				gFileList.push(viewFile,listFile,editFile);
			}
			
			updateMainView();			
			gFileList.push(mainEventMap,modelMap);
			
			as3_types.push(voGFile.name);
			
			return gFileList;
		}
	}
}