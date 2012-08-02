package org.commnoslibs.report.models.types
{
	
	import mx.controls.NumericStepper;
	import mx.core.UIComponent;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTypeFloat extends JRTypeInteger implements JRParameterType
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		override public function get type():String
		{
			return "java.lang.Float";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function JRTypeFloat()
		{
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		override public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var field:NumericStepper = super.addParameterField(value) as NumericStepper;
			field.stepSize = 0.01;
			
			return field;
		}
	}
}