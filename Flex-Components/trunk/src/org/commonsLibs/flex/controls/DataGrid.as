package org.commonsLibs.flex.controls
{
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.controls.DataGrid;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.DataGridEvent;
	
	public class DataGrid extends mx.controls.DataGrid
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		[Bindable]
		public var includeItemFunction:Function;
		
		[Bindable]
		public var validateInclude:Function;
		
		private var _excelEdit:Boolean
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function DataGrid()
		{
			super();
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function get excelEdit():Boolean
		{
			return _excelEdit;
		}
		
		[Bindable]
		public function set excelEdit(v:Boolean):void
		{
			_excelEdit = editable = v;
			
			if (v)
			{
				addEventListener(FocusEvent.FOCUS_IN, excelFocusInHandler);
				addEventListener(KeyboardEvent.KEY_UP, excelKeyUpHandler);
				addEventListener(DataGridEvent.ITEM_EDIT_END, itemEditEndHandler);
			}
			else
			{
				removeEventListener(FocusEvent.FOCUS_IN, excelFocusInHandler);
				removeEventListener(KeyboardEvent.KEY_UP, excelKeyUpHandler);
				removeEventListener(DataGridEvent.ITEM_EDIT_END, itemEditEndHandler);
			}
		}
		
		//Gets the reference to the parent object where a property will be updated
		override protected function deriveComplexFieldReference(data:Object, complexFieldNameComponents:Array):Object
		{
			var currentRef:Object = data;
			
			if (complexFieldNameComponents)
			{
				for (var i:int = 0; i < complexFieldNameComponents.length; i++)
				{
					if (currentRef && currentRef.hasOwnProperty(complexFieldNameComponents[i]))
					{
						currentRef = currentRef[complexFieldNameComponents[i]];
					}
				}
			}
			
			if (currentRef)
			{
				return currentRef;
			}
			else
			{
				return "";
			}
		}
		
		// turn off selection indicator
		/* override protected function drawSelectionIndicator(
		   indicator:Sprite, x:Number, y:Number,
		   width:Number, height:Number, color:uint,
		   itemRenderer:IListItemRenderer):void
		   {
		 } */
		
		// whenever we draw the renderer, make sure we re-eval the checked state
		override protected function drawItem(item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false):void
		{
			if (item && item is CheckBox)
			{
				CheckBox(item).invalidateProperties();
				super.drawItem(item, selected, highlighted, caret, transition);
			}
		}
		
		protected function excelFocusInHandler(event:FocusEvent):void
		{
			if (includeItemFunction == null)
			{
				throw new Error("A propriedade includeItemFunction não foi propriamente definida.");
			}
			else if (!dataProvider.length)
			{
				ArrayCollection(dataProvider).addItem(includeItemFunction());
				setTimeout(editItens, 100);
			}
		}
		
		protected function excelKeyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.DELETE)
			{
				if (selectedItem && selectedIndex < dataProvider.length)
				{
					dataProvider.removeItemAt(selectedIndex);
				}
			}
		}
		
		// fake all keyboard interaction as if it had the ctrl key down
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			// this is technically illegal, but works
			event.ctrlKey = true;
			event.shiftKey = false;
			super.keyDownHandler(event);
		}
		
		override protected function selectItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true):Boolean
		{
			// only run selection code if a checkbox was hit and always
			// pretend we're using ctrl selection
			if (item is CheckBox)
			{
				return super.selectItem(item, false, true, transition);
			}
			else
			{
				return super.selectItem(item, false, false, transition);
			}
			return false;
		}
		
		//Passing all of these parameters as it basically allows everything you would need to subclass for all sorts of fun implementations
		override protected function setNewValue(data:Object, property:String, value:Object, columnIndex:int):Boolean
		{
			if (!isComplexColumn(property))
			{
				data[property] = value;
			}
			else
			{
				var complexFieldNameComponents:Array = property.split(".");
				var lastProp:String = complexFieldNameComponents.pop();
				var parent:Object = deriveComplexFieldReference(data, complexFieldNameComponents);
				
				if (parent && parent.hasOwnProperty(lastProp))
				{
					parent[lastProp] = value;
				}
			}
			
			//The value they typed in is always converted to a string, but is the value actually a string in the dataprovider?
			//unknown as it is cast by datagridcolumn before datagrid ever gets to know...
			//control if this really causes an update in subclass
			return true;
		}
		
		private function editItens():void
		{
			editedItemPosition = { columnIndex: 0, rowIndex: dataProvider.length - 1 }
		}
		
		private function itemEditEndHandler(event:DataGridEvent):void
		{
			if (includeItemFunction == null)
			{
				throw new Error("A propriedade includeItemFunction não foi propriamente definida.");
			}
			else if (validateInclude == null)
			{
				throw new Error("A propriedade validateInclude não foi propriamente definida.");
			}
			else
			{
				if (event.columnIndex == columns.length - 1 && event.rowIndex == dataProvider.length - 1)
				{
					if (validateInclude(selectedItem))
					{
						ArrayCollection(dataProvider).addItem(includeItemFunction());
						
						selectedIndex = dataProvider.length - 1;
						validateNow();
						setTimeout(editItens, 100);
					}
				}
			}
		}
	}
}