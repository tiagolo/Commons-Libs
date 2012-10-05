package org.commonsLibs.controls
{
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.List;
	import mx.controls.listClasses.IListItemRenderer;
	
	/**
	 *  List that uses checkboxes for multiple selection
	 */
	public class List extends mx.controls.List
	{
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		// whenever we draw the renderer, make sure we re-eval the checked state
		override protected function drawItem(item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false):void
		{
			CheckBox(item).invalidateProperties();
			super.drawItem(item, selected, highlighted, caret, transition);
		}
		
		// turn off selection indicator
		override protected function drawSelectionIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void
		{
		}
		
		// fake all keyboard interaction as if it had the ctrl key down
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			// this is technically illegal, but works
			event.ctrlKey = true;
			event.shiftKey = false;
			super.keyDownHandler(event);
		}
		
		// fake all mouse interaction as if it had the ctrl key down
		override protected function selectItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true):Boolean
		{
			return super.selectItem(item, false, true, transition);
		}
	}

}