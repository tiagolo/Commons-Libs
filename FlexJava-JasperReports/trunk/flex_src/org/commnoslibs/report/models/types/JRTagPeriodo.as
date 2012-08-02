package org.commnoslibs.report.models.types
{
	
	import mx.containers.HBox;
	import mx.controls.DateField;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTagPeriodo implements JRParameterType
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
			return "[periodo]";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function JRTagPeriodo()
		{
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var hbox:HBox = new HBox();
			var field1:DateField = new DateField();
			var field2:DateField = new DateField();
			var label:Label = new Label();
			
			field1.name = "inicial";
			field2.name = "final";
			field1.formatString = field2.formatString = "DD/MM/YYYY";
			label.text = "à";
			
			hbox.addChild(field1);
			hbox.addChild(label);
			hbox.addChild(field2);
			
			hbox.name = value.name;
			hbox.data = value;
			value.field = hbox;
			
			return hbox;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			var formater:DateFormatter = new DateFormatter();
			formater.formatString = "DD/MM/YYYY";
			
			var inicial:DateField = DateField(Container(value.field).getChildByName("inicial"));			
			var final:DateField = DateField(Container(value.field).getChildByName("final"));			
				
			var dtInicial:String = "TO_DATE('" + formater.format(inicial.selectedDate) + " 00:00:00', 'DD/MM/YYYY HH24:MI:SS')";
			var dtFinal:String = "TO_DATE('" + formater.format(final.selectedDate) + " 23:59:59', 'DD/MM/YYYY HH24:MI:SS')";

			value.field.errorString = null;
			
			if(!inicial.selectedDate || !final.selectedDate)
			{
				value.field.errorString = "Por favor selecione um período válido";
			}
			else if(inicial.errorString)
			{
				value.field.errorString = inicial.errorString;
			}
			else if(final.errorString)
			{
				value.field.errorString = final.errorString;
			}
			else if(inicial.selectedDate > final.selectedDate)
			{
				value.field.errorString = "A data inicial não pode ser maior que a data final";
			}
			
			return dtInicial + " AND " + dtFinal;
		}
	}
}