package org.commnoslibs.report.models.types
{
	
	import mx.controls.CheckBox;
	import mx.core.UIComponent;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTypeBoolean implements JRParameterType
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public function get type():String
		{
			return "java.lang.Boolean";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var field:CheckBox = new CheckBox();
			field.name = value.name;
			field.data = value;
			
			value.field = field;
			return field;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			return CheckBox(value.field).selected;
		}
	}
}