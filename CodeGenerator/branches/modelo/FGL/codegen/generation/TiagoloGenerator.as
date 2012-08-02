package codegen.generation
{
	import codegen.analysis.PseudoClass;
	import codegen.analysis.PseudoClassMethod;
	import codegen.analysis.PseudoVariable;
	import codegen.analysis.RemoteService;
	import codegen.utils.StringTools;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	public class TiagoloGenerator
	{
		public var useDelegate:Boolean = false ;
		
		public var packageConfig:PackageConfig;		
		
		public var templateMgr:TemplateManager = TemplateManager.getInstance();
		
		public function TiagoloGenerator(pConfig:PackageConfig)
		{
			packageConfig = pConfig;
		}
		
		protected function replacePackageNames(pOriginal:String):String
		{
			var str:String = pOriginal;
			str = str.replace(/\*MODELPACKAGE\*/g, packageConfig.modelFullPath);
			str = str.replace(/\*VIEWPACKAGE\*/g, packageConfig.viewFullPath);
			str = str.replace(/\*EVENTSPACKAGE\*/g, packageConfig.eventsFullPath);
			str = str.replace(/\*BUSINESSPACKAGE\*/g, packageConfig.businessFullPath);
			str = str.replace(/\*DAOPACKAGE\*/g, packageConfig.daoFullPath);
			str = str.replace(/\*SERVICEPACKAGE\*/g, packageConfig.serviceFullPath);
			
			return str;
		}
		
		public function generateMainEventMap(pVOCollec:ArrayCollection):GeneratedFile
		{
			var str:String="";
			for (var i:int = 0; i < pVOCollec.length; i++)
			{
				var pName:String = pVOCollec[i].name;
				var lcVoName:String  = StringTools.lowerFirstChar(pName);
				str += "<!-- "+pName.toUpperCase()+" -->\n";
				str += '<mate:EventHandlers type="{'+pName+'Event.FIND_ALL}" debug="true">\n';
				str += '	<mate:MethodInvoker generator="{'+pName+'Manager}" method="findAll" arguments="{[event.'+lcVoName+',event.properties,event.validators]}"/>\n';
				str += '</mate:EventHandlers>\n';
				str += '<mate:EventHandlers type="{'+pName+'Event.SAVE}" debug="true">\n';
				str += '	<mate:MethodInvoker generator="{'+pName+'Manager}" method="save" arguments="{[event.'+lcVoName+',event.validators]}"/>\n';
				str += '</mate:EventHandlers>\n';
				str += '<mate:EventHandlers type="{'+pName+'Event.EDIT}" debug="true">\n';
				str += '	<mate:MethodInvoker generator="{'+pName+'Manager}" method="edit" arguments="{event.'+lcVoName+'}"/>\n';
				str += '</mate:EventHandlers>\n';
				str += '<mate:EventHandlers type="{'+pName+'Event.REMOVE}" debug="true">\n';
				str += '	<mate:MethodInvoker generator="{'+pName+'Manager}" method="remove" arguments="{event.'+lcVoName+'}"/>\n';
				str += '</mate:EventHandlers>\n\n';
			}

			var asFile:GeneratedFile = new GeneratedFile("MainEventMap", "as", "eventMaps");
			asFile.code = str ;
			
			return asFile;
		}
		
		public function generateModelMap(pVOCollec:ArrayCollection):GeneratedFile
		{
			var str:String="";
			for (var i:int = 0; i < pVOCollec.length; i++)
			{
				var pName:String = pVOCollec[i].name;
				var lcVoName:String  = StringTools.lowerFirstChar(pName);
				str += '<mate:Injectors target="{'+pName+'View}">\n';
				str += '	<mate:ListenerInjector eventType="{'+pName+'Event.STATE_CHANGE}" method="stateChangeHandler"/>\n';
				str += '	<mate:PropertyInjector targetKey="'+lcVoName+'" source="{'+pName+'Manager}" sourceKey="item" />\n';
				str += '	<mate:PropertyInjector targetKey="lista" source="{'+pName+'Manager}" sourceKey="lista" />\n';
				str += '</mate:Injectors>\n\n';
			}
			var asFile:GeneratedFile = new GeneratedFile("ModelMap", "as", "eventMaps");
			asFile.code = str ;
			
			return asFile;
		}
		
		public function generateVO(pOriginalFile:PseudoClass, className:String=null):GeneratedFile
		{
			
			var pTemplate:String = templateMgr.voTemplateStr;
			
			if(className==null) className = pOriginalFile.className;
			
			var str:String = replacePackageNames(pTemplate);
			
			//imports
			str = str.replace(/\*IMPORTS\*/, "");
			
			//metadata
			str = str.replace(/\*QUALIFIED_REMOTE_CLASS\*/, pOriginalFile.qualifiedClassName);
			
			//class, constructor
			str = str.replace(/\*VO\*/g, className);
			
			//properties
			var s:String="";
			
			var getsets:String="";
			for ( var i:int = 0 ; i < pOriginalFile.properties.length ; i++)
			{
				var variable:PseudoVariable = pOriginalFile.properties[i] as PseudoVariable;
				
				if(!variable.isGetSet)
				{
					s+="\t\t"+"public var "+ variable.name+":"+variable.type+";\n";				
				}
					
				else 
				{
					s+="\t\t"+"private var _"+ variable.name+":"+variable.type+";\n";	
					
					getsets+="\t\tpublic function get "+variable.name+"():"+variable.type+"{\n";		
					getsets+="\t\t\treturn _"+variable.name+";\n";
					getsets+="\t\t}\n\n";
					getsets+="\t\tpublic function set "+variable.name+"(pData:"+variable.type+"):void{\n";		
					getsets+="\t\t\t_"+variable.name+"=pData;\n";
					getsets+="\t\t}\n\n";
				}
				
			}
			str =  str.replace(/\*PROPERTIES\*/, s);
			str =  str.replace(/\*GETTERSETTERS\*/, getsets);
			
			var asFile:GeneratedFile = new GeneratedFile(className, "as", packageConfig.modelDir);
			asFile.code = str ;
			
			return asFile;
			
		}
		
		public function generateVOEvent(pOriginalFile:GeneratedFile, className:String=null, pQualifiedSuperClass:String=null):GeneratedFile
		{
			if(!pQualifiedSuperClass)
			{
				pQualifiedSuperClass = packageConfig.eventsFullPath+".GenericEvent";
			}
			
			var pTemplate:String = templateMgr.MATE_EventTemplateStr;
			
			if(className==null) className = pOriginalFile.name;
			
			var eventSuperClassName:String = pQualifiedSuperClass.substring(pQualifiedSuperClass.lastIndexOf(".")+1);
			
			var uClassName:String = className.toUpperCase();
			//____
			
			var str:String = replacePackageNames(pTemplate);
			
			
			//imports
			str = str.replace(/\*IMPORTS\*/, "import "+pQualifiedSuperClass+";");
			
			//class
			str = str.replace(/\*EVENT_SUPERCLASS\*/g, eventSuperClassName);
			str =  str.replace(/\*UP_VO\*/g, className.toUpperCase());	
			var lcVoName:String  = StringTools.lowerFirstChar(className);
			str =  str.replace(/\*LC_VO\*/g, lcVoName);					
			str = str.replace(/\*VO\*/g, className);		
			
			var asFile:GeneratedFile = new GeneratedFile(className+"Event", "as", packageConfig.eventsDir);
			asFile.code = str ;
			
			return asFile;
			
		}
		
		public function generateVOManager(pASVOFile:GeneratedFile):GeneratedFile
		{
			return generateVOtranscodedFile(pASVOFile,templateMgr.MATE_FlexManagerTemplateStr,"Manager","as",packageConfig.businessDir);
		}
		public function generateVODao(pASVOFile:GeneratedFile):GeneratedFile
		{
			return generateVOtranscodedFile(pASVOFile,templateMgr.SPRING_JavaDaoTemplateStr,"Dao","java",packageConfig.daoDir);
		}
		public function generateVODaoHibernate(pASVOFile:GeneratedFile):GeneratedFile
		{
			return generateVOtranscodedFile(pASVOFile,templateMgr.SPRING_JavaDaoHibernateTemplateStr,"DaoHibernate","java",packageConfig.daoDir);
		}
		public function generateVOService(pASVOFile:GeneratedFile):GeneratedFile
		{
			return generateVOtranscodedFile(pASVOFile,templateMgr.SPRING_JavaServiceTemplateStr,"Service","java",packageConfig.serviceDir);
		}
		public function generateVOServiceImpl(pASVOFile:GeneratedFile):GeneratedFile
		{
			return generateVOtranscodedFile(pASVOFile,templateMgr.SPRING_JavaServiceImplTemplateStr,"ServiceImpl","java",packageConfig.serviceDir);
		}
		
		public function generateUIView(pASVOFile:GeneratedFile):GeneratedFile
		{
			var pTemplate:String = templateMgr.MATE_UIViewTemplateStr;
			
			var str:String = replacePackageNames(pTemplate);
			
			str =  str.replace(/\*UP_VO\*/g, pASVOFile.name.toUpperCase());			
			str =  str.replace(/\*VO\*/g, pASVOFile.name);
			var lcVoName:String  = StringTools.lowerFirstChar(pASVOFile.name);
			str =  str.replace(/\*LC_VO\*/g, lcVoName);
			
			var asFile:GeneratedFile = new GeneratedFile(pASVOFile.name+"View", "mxml", packageConfig.viewDir+"/"+lcVoName);
			asFile.code = str ;
			
			return asFile;
		}
		
		public function generateUIList(pASVOFile:GeneratedFile):GeneratedFile
		{
			var pTemplate:String = templateMgr.MATE_UIListTemplateStr;
			
			var str:String = replacePackageNames(pTemplate);
			
			str =  str.replace(/\*UP_VO\*/g, pASVOFile.name.toUpperCase());			
			str =  str.replace(/\*VO\*/g, pASVOFile.name);
			var lcVoName:String  = StringTools.lowerFirstChar(pASVOFile.name);
			str =  str.replace(/\*LC_VO\*/g, lcVoName);
			
			
			var cols:String="";
			
			var properties:Array = pASVOFile.code.match(/public var \w+/g);
			
			for (var i:int = 0 ; i < properties.length ; i++)
			{
				var pName:String = properties[i].substring(11);
				cols+="\t\t\t<mx:DataGridColumn headerText='"+pName+"' dataField='"+pName+"'/>\n";
			}
			
			str =  str.replace(/\*DGCOLUMNS\*/g, cols);
			
			
			var asFile:GeneratedFile = new GeneratedFile(pASVOFile.name+"List", "mxml", packageConfig.viewDir+"/"+lcVoName);
			asFile.code = str ;
			
			return asFile;
			
		}
		
		public function generateUIEdit(pASVOFile:GeneratedFile ):GeneratedFile
		{
			
			var pTemplate:String = templateMgr.MATE_UIEditTemplateStr;
			
			var str:String = replacePackageNames(pTemplate);
			
			str =  str.replace(/\*UP_VO\*/g, pASVOFile.name.toUpperCase());			
			str =  str.replace(/\*VO\*/g, pASVOFile.name);
			var lcVoName:String  = StringTools.lowerFirstChar(pASVOFile.name);
			str =  str.replace(/\*LC_VO\*/g, lcVoName);
			
			var props:String="";
			var formItems:String="";
			
			var properties:Array = pASVOFile.code.match(/public var \w+:\w+/g);
			
			for (var i:int = 0 ; i < properties.length ; i++)
			{
				var typedName:String = properties[i].substring(11);
				var tab:Array = typedName.split(":");
				var pName:String = tab[0];
				var pType:String = tab[1];
				
				formItems+="\t\t"+'<mx:FormItem label="'+pName+'" enabled="'+Boolean(pName != 'id')+'">\n';
				
				if(pType=="String")
				{
					formItems+=	"\t\t\t"+'<mx:TextInput id="tx'+StringTools.upperFirstChar(pName)+'" text="{'+lcVoName+'.'+pName+'}"/>\n';
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="tx'+StringTools.upperFirstChar(pName)+'.text"/>\n';
				}
				else if(pType=="int")
				{
					formItems+=	"\t\t\t"+'<mx:TextInput restrict="0123456789\-" id="tx'+StringTools.upperFirstChar(pName)+'" text="{'+lcVoName+'.'+pName+'}"/>\n';					
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="int(tx'+StringTools.upperFirstChar(pName)+'.text)"/>\n';
				}
				else if(pType=="Number")
				{
					formItems+=	"\t\t\t"+'<mx:TextInput restrict=".,0123456789\-" id="tx'+StringTools.upperFirstChar(pName)+'" text="{'+lcVoName+'.'+pName+'}"/>\n';
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="Number(tx'+StringTools.upperFirstChar(pName)+'.text)"/>\n';
				}
				else if(pType=="Date")
				{
					formItems+=	"\t\t\t"+'<mx:DateField id="df'+StringTools.upperFirstChar(pName)+'" selectedDate="{'+lcVoName+'.'+pName+'}"/>\n';															
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="df'+StringTools.upperFirstChar(pName)+'.selectedDate"/>\n';
				}
				else if(pType=="Boolean")
				{
					formItems+=	"\t\t\t"+'<mx:CheckBox id="cb'+StringTools.upperFirstChar(pName)+'" selected="{'+lcVoName+'.'+pName+'}"/>\n';															
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="cb'+StringTools.upperFirstChar(pName)+'.selected"/>\n';
				}
				else 
				{
					formItems+=	"\t\t\t"+'<mx:TextInput id="tx'+StringTools.upperFirstChar(pName)+'" text="{'+lcVoName+'.'+pName+'}"/>\n';
					props+="\t"+'<mx:Binding destination="'+lcVoName+"."+pName+'" source="tx'+StringTools.upperFirstChar(pName)+'.text"/>\n';			
				}
				
				formItems+=	'\t\t</mx:FormItem>\n';
			}
			
			str =  str.replace(/\*BINDINGS\*/g, props);
			str =  str.replace(/\*FORMITEMS\*/, formItems);
			
			
			var asFile:GeneratedFile = new GeneratedFile(pASVOFile.name+"Edit", "mxml", packageConfig.viewDir+"/"+lcVoName);
			asFile.code = str ;
			
			return asFile;
			
		}
		
		protected function generateVOtranscodedFile(pASVOFile:GeneratedFile,templateStr:String,classSufix:String,fileExtention:String,packageDir:String):GeneratedFile
		{
			var pTemplate:String = templateStr;
			
			var str:String = replacePackageNames(pTemplate);
			
			//class
			str =  str.replace(/\*UP_VO\*/g, pASVOFile.name.toUpperCase());			
			str =  str.replace(/\*VO\*/g, pASVOFile.name);
			var lcVoName:String  = StringTools.lowerFirstChar(pASVOFile.name);
			str =  str.replace(/\*LC_VO\*/g, lcVoName);
			
			var geFile:GeneratedFile = new GeneratedFile(pASVOFile.name+classSufix, fileExtention, packageDir);
			geFile.code = str ;
			
			return geFile;
		}
	}
}