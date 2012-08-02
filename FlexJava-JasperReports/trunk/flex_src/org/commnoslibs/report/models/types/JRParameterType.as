package org.commnoslibs.report.models.types
{
	import mx.core.UIComponent;
	
	import org.commnoslibs.report.models.JRDesignParameter;

	public interface JRParameterType
	{

		function JRParameterType();

		function addParameterField(value:JRDesignParameter):UIComponent;
		function getParameterValue(value:JRDesignParameter):Object;
		function get type():String;
	}
}
