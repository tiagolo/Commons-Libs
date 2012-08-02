package org.commnoslibs.report.models.types
{
	
	import mx.controls.DateField;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTypeDate implements JRParameterType
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
			return "java.util.Date";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function JRTypeDate()
		{
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var field:DateField = new DateField();
			field.formatString = "DD/MM/YYYY"
			field.name = value.name;
			field.data = value;
			
			value.field = field;
			return field;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			var formater:DateFormatter = new DateFormatter();
			formater.formatString = "DD/MM/YYYY JJ:NN:SS"
			return formater.format(DateField(value.field).selectedDate);
		}
	}
}