package org.commnoslibs.report.models.types
{
	import mx.core.UIComponent;
	import org.commnoslibs.report.models.JRDesignParameter;
	import spark.components.TextInput;

	public class JRTypeString implements JRParameterType
	{

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
			var field:TextInput = new TextInput();
			field.name = value.name;
			//field.data = value;
			field.width = 250;

			value.field = field;
			return field;
		}

		public function getParameterValue(value:JRDesignParameter):Object
		{
			return TextInput(value.field).text;
		}

		public function get type():String
		{
			return "java.lang.String";
		}
	}
}
