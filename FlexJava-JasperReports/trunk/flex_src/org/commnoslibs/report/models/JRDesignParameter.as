package org.commnoslibs.report.models
{
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import org.commnoslibs.report.models.types.JRParameterType;
	
	[Bindable]
	[RemoteClass(alias="br.com.mv.report.model.JRDesignParameter")]
	public class JRDesignParameter
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public var defaultValueExpression:Object;
		
		public var description:String;
		
		public var designProperties:ArrayCollection;
		
		public var field:UIComponent;
		
		public var forPrompting:Boolean = true;
		
		public var name:String;
		
		public var nestedType:Object;
		
		public var nestedTypeName:String;
		
		public var propertiesMap:Object;
		
		public var systemDefined:Boolean;
		
		public var type:JRParameterType;
		
		public var valueClass:Object;
		
		public var valueClassName:String;
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function isInvisible():Boolean
		{
			if (name && 0 <= name.indexOf("]") < name.indexOf("["))
			{
				return true;
			}
			
			return false;
		}
		
		public function isRequired():Boolean
		{
			if (name && 0 <= name.indexOf("[[") < name.indexOf("]]"))
			{
				return true;
			}
			
			return false;
		}
		
		public function isTag():Boolean
		{
			if (name && 0 <= name.indexOf("[") < name.indexOf("]"))
			{
				return true;
			}
			
			return false;
		}
	}
}

