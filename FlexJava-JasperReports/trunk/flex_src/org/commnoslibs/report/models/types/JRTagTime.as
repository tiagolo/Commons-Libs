package org.commnoslibs.report.models.types
{
	import com.yahoo.astra.mx.controls.TimeStepper;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import org.commnoslibs.report.models.JRDesignParameter;

	public class JRTagTime implements JRParameterType
	{

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function JRTagTime()
		{
		}

		//--------------------------------------
		//   Function 
		//--------------------------------------

		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var field:TimeStepper = new TimeStepper();
			field.setStyle("showSeconds", false);
			field.setStyle("showAMPM", false);
			field.setStyle("useTwelveHourFormat", false);
			field.value = null;
			field.name = value.name;

			var horario:Date = new Date();
			if (value.name.search("Final") > 0 || value.name.search("final") > 0)
			{
				horario.hours = 23;
				horario.minutes = 59;
				field.value = horario;
			}
			else if (value.name.search("Inicial") > 0 || value.name.search("inicial") > 0)
			{
				horario.hours = 0;
				horario.minutes = 0;
				field.value = horario;
			}

			value.field = field;
			return field;
		}

		public function getParameterValue(value:JRDesignParameter):Object
		{
			var formater:DateFormatter = new DateFormatter();
			formater.formatString = "JJ:NN";
			return formater.format(TimeStepper(value.field).value);
		}

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
			return "[hora]";
		}
	}
}

