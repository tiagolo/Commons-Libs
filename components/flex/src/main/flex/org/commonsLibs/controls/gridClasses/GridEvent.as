package org.commonsLibs.controls.gridClasses
{
	import flash.display.InteractiveObject;
	import spark.components.gridClasses.GridColumn;
	import spark.components.gridClasses.IGridItemRenderer;
	import spark.events.GridEvent;

	public class GridEvent extends spark.events.GridEvent
	{
		public static const GRID_ITEM_REMOVED:String = "gridItemRemoved";

		public function GridEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0, rowIndex:int = -1, columnIndex:int = -1, column:GridColumn = null, item:Object = null, itemRenderer:IGridItemRenderer = null)
		{
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, rowIndex, columnIndex, column, item, itemRenderer);
		}
	}
}
