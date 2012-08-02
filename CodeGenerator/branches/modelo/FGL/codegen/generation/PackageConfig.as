package codegen.generation
{
	
	/**
	 * 
	 * @author davidderaedt
	 * 
	 * Represents the desired package structure for the generated app
	 * 
	 */
	 	
	[Bindable]
	public class PackageConfig
	{
				
		public var modelPackageName:String="model";		
		public var voPackageName:String="vo";
		
		public var viewPackageName:String="views";
		public var componentsPackageName:String="components";		
		
		public var controlPackageName:String="control";
		public var commandPackageName:String="command";
		
		public var businessPackageName:String="business";
		
		public var eventsPackageName:String="events";

		public var mainPackageName:String="";
		
		public var daoPackageName:String = "dao"
		public var servicePackageName:String = "services"

		public function get mainPath():String
		{
			return mainPackageName;
		}


		public function get modelDir():String
		{
			return modelPackageName;
		}
		public function get modelFullPath():String
		{
			return mainPackageName+"."+modelPackageName;
		}
		
		public function get voDir():String
		{
			return modelPackageName+"/"+voPackageName;
		}
		public function get voFullPath():String
		{
			return mainPackageName+"."+modelPackageName+"."+voPackageName;
		}
		
		public function get viewDir():String
		{
			return viewPackageName;
		}
		public function get viewFullPath():String
		{
			return mainPackageName+"."+viewPackageName;
		}		
		
		public function get componentsDir():String
		{
			return viewPackageName+"/"+componentsPackageName;
		}
		public function get componentsFullPath():String
		{
			return mainPackageName+"."+ viewPackageName +"."+ componentsPackageName;
		}

		public function get controlDir():String
		{
			return controlPackageName;
		}
		public function get controlFullPath():String
		{
			return mainPackageName+"."+ controlPackageName;
		}		

		public function get commandDir():String
		{
			return controlPackageName+"/"+ commandPackageName;
		}
		public function get commandFullPath():String
		{
			return mainPackageName+"."+ controlPackageName+"."+ commandPackageName;
		}		

		public function get businessDir():String
		{
			return businessPackageName;
		}
		public function get businessFullPath():String
		{
			return mainPackageName+"."+ businessPackageName;
		}		

		public function get eventsDir():String
		{
			return eventsPackageName;
		}
		public function get eventsFullPath():String
		{
			return mainPackageName+"."+ eventsPackageName;
		}

		public function get daoDir():String
		{
			return daoPackageName;
		}
		public function get daoFullPath():String
		{
			return mainPackageName+"."+ daoPackageName;
		}

		public function get serviceDir():String
		{
			return servicePackageName;
		}
		public function get serviceFullPath():String
		{
			return mainPackageName+"."+ servicePackageName;
		}
		
	}
}