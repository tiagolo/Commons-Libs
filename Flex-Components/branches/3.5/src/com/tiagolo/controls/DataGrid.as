package com.tiagolo.controls
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.DataGridEvent;

	public class DataGrid extends mx.controls.DataGrid
	{
		[Bindable]
		public var includeItemFunction:Function;
		[Bindable]
		public var validateInclude:Function;
		
		private var _excelEdit:Boolean
		
		public function DataGrid()
		{
			super();
		}
		
		public function get excelEdit():Boolean
		{
			return _excelEdit;
		}
		
		[Bindable]
		public function set excelEdit(v:Boolean):void
		{
			_excelEdit = editable = v;
			if(v)
			{
				addEventListener(FocusEvent.FOCUS_IN,excelFocusInHandler);
				addEventListener(KeyboardEvent.KEY_UP, excelKeyUpHandler);
				addEventListener(DataGridEvent.ITEM_EDIT_END, itemEditEndHandler);
			}
			else
			{
				removeEventListener(FocusEvent.FOCUS_IN,excelFocusInHandler);
				removeEventListener(KeyboardEvent.KEY_UP, excelKeyUpHandler);
				removeEventListener(DataGridEvent.ITEM_EDIT_END, itemEditEndHandler);
			}
		}
		
		protected function excelFocusInHandler(event:FocusEvent):void
		{
			if(includeItemFunction == null)
			{
				throw new Error("A propriedade includeItemFunction não foi propriamente definida.");
			}
			else if(!dataProvider.length)
			{
				ArrayCollection(dataProvider).addItem(includeItemFunction());
				setTimeout(editItens,100);
			}
		}
		
		protected function excelKeyUpHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.DELETE)
			{
				if(selectedItem && selectedIndex < dataProvider.length) dataProvider.removeItemAt(selectedIndex);
			}
		}
		
		private function itemEditEndHandler(event:DataGridEvent):void
		{
			if(includeItemFunction == null)
			{
				throw new Error("A propriedade includeItemFunction não foi propriamente definida.");
			}
			else if(validateInclude == null)
			{
				throw new Error("A propriedade validateInclude não foi propriamente definida.");
			}
			else 
			{
				if(event.columnIndex == columns.length - 1 && event.rowIndex == dataProvider.length -1)
				{
					if(validateInclude(selectedItem))
					{
						ArrayCollection(dataProvider).addItem(includeItemFunction());
						
						selectedIndex = dataProvider.length - 1;
						validateNow();
						setTimeout(editItens,100);
					}
				}
			}
		}
		
		private function editItens():void
		{
			editedItemPosition = {columnIndex:0, rowIndex:dataProvider.length - 1}
		}
		
		//Gets the reference to the parent object where a property will be updated
		override protected function deriveComplexFieldReference( data:Object, complexFieldNameComponents:Array ):Object
		{
			var currentRef:Object = data;
			if ( complexFieldNameComponents ) 
			{
				for ( var i:int=0; i<complexFieldNameComponents.length; i++ )
					if(currentRef && currentRef.hasOwnProperty(complexFieldNameComponents[ i ]))
					{
						currentRef = currentRef[ complexFieldNameComponents[ i ] ];
					}
			}
			if(currentRef)
				return currentRef;
			else
				return "";
		}
		
		//Passing all of these parameters as it basically allows everything you would need to subclass for all sorts of fun implementations
		override protected function setNewValue( data:Object, property:String, value:Object, columnIndex:int ):Boolean 
		{
			if ( !isComplexColumn( property ) )
			{
				data[ property ] = value;
			} 
			else 
			{
				var complexFieldNameComponents:Array = property.split( "." );
				var lastProp:String = complexFieldNameComponents.pop();
				var parent:Object = deriveComplexFieldReference( data, complexFieldNameComponents );
				if(parent && parent.hasOwnProperty(lastProp))
				parent[ lastProp ] = value;
			}
			
			//The value they typed in is always converted to a string, but is the value actually a string in the dataprovider?
			//unknown as it is cast by datagridcolumn before datagrid ever gets to know...
			//control if this really causes an update in subclass
			return true;
		}
	}
}