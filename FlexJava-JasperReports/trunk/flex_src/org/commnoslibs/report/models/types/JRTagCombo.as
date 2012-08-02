package org.commnoslibs.report.models.types
{
	
	import mx.core.UIComponent;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	import spark.components.DropDownList;
	
	public class JRTagCombo implements JRParameterType
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
			var field:DropDownList = new DropDownList();
			field.dataProvider = value.designProperties;
			field.selectedIndex = -1;
			field.prompt = "SELECIONE UM ITEM"
			field.name = value.name;
			field.width = 250;
			
			value.field = field;
			return field;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			if (DropDownList(value.field).selectedItem)
			{
				return DropDownList(value.field).selectedItem.data;
			}
			else
			{
				return "";
			}
		}
		
		public function get type():String
		{
			return "[combo]";
		}
	}
}