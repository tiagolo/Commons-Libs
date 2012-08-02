package org.commnoslibs.report.models.types
{
	import mx.controls.NumericStepper;
	import mx.core.UIComponent;
	import org.commnoslibs.report.models.JRDesignParameter;

	public class JRTypeInteger implements JRParameterType
	{

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function JRTypeInteger()
		{
		}

		//--------------------------------------
		//   Function 
		//--------------------------------------

		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var field:NumericStepper = new NumericStepper();
			field.stepSize = 1;
			field.maximum = 999999999;
			field.maxChars = 9;
			field.name = value.name;
			field.data = value;

			value.field = field;
			return field;
		}

		public function getParameterValue(value:JRDesignParameter):Object
		{
			var parameterValue:Object = NumericStepper(value.field).value;

			if (value.isRequired() && !parameterValue)
			{
				parameterValue = null;
			}

			return parameterValue;
		}

		public function get type():String
		{
			return "java.lang.Integer";
		}
	}
}
