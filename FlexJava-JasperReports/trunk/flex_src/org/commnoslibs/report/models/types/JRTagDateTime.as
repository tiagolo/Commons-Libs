package org.commnoslibs.report.models.types
{
	
	import com.yahoo.astra.mx.controls.TimeStepper;
	
	import mx.containers.HBox;
	import mx.controls.DateField;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTagDateTime implements JRParameterType
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
			return "[datahora]";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function JRTagDateTime()
		{
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var hbox:HBox = new HBox();
			
			var field1:DateField = new DateField();
			field1.formatString = "DD/MM/YYYY"
			field1.name = "data";
			
			var field2:TimeStepper = new TimeStepper();
			field2.setStyle("showSeconds",false);
			field2.setStyle("showAMPM",false);
			field2.setStyle("useTwelveHourFormat",false);
			field2.value = null;
			field2.name = "hora";
			
			hbox.addChild(field1);
			hbox.addChild(field2);
			hbox.name = value.name;
			hbox.data = value;
			value.field = hbox;
			return hbox;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			var dtFormater:DateFormatter = new DateFormatter();
			dtFormater.formatString = "DD/MM/YYYY";
			
			var hrFormater:DateFormatter = new DateFormatter();
			hrFormater.formatString = "JJ:NN";
			
			var dataField:DateField = DateField(Container(value.field).getChildByName("data"));			
			var horaField:TimeStepper = TimeStepper(Container(value.field).getChildByName("hora"));			
			
			var data:String = dtFormater.format(dataField.selectedDate);
			var hora:String = hrFormater.format(horaField.value);
			
			if(hora) hora = " " + hora;
			
			return data + hora;
		}
	}
}

