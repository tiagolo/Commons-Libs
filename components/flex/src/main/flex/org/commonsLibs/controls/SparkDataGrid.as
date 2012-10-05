package org.commonsLibs.controls
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import mx.collections.ArrayCollection;
	import org.commonsLibs.controls.gridClasses.GridEvent;
	import spark.components.DataGrid;
	import spark.events.GridItemEditorEvent;

	[Event(name="gridItemRemoved", type="org.commonsLibs.flex.controls.gridClasses.GridEvent")]
	public class SparkDataGrid extends DataGrid
	{

		private var _excelEdit:Boolean;

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
				addEventListener(GridItemEditorEvent.GRID_ITEM_EDITOR_SESSION_SAVE, itemEditEndHandler);
			}
			else
			{
				removeEventListener(FocusEvent.FOCUS_IN, excelFocusInHandler);
				removeEventListener(KeyboardEvent.KEY_UP, excelKeyUpHandler);
				removeEventListener(GridItemEditorEvent.GRID_ITEM_EDITOR_SESSION_SAVE, itemEditEndHandler);
			}
		}
		[Bindable]
		public var includeItemFunction:Function;

		[Bindable]
		public var validateInclude:Function;

		public function SparkDataGrid()
		{
			super();
		}

		public function addItem(lastItem:Boolean = true):void
		{
			if (dataProvider.length)
			{
				if (lastItem)
				{
					selectedIndex = dataProvider.length - 1;
				}

				if (selectedItem && this.validateInclude(selectedItem))
				{
					ArrayCollection(dataProvider).addItem(this.includeItemFunction());
					selectedIndex = dataProvider.length - 1;
					validateNow();
					setTimeout(this.editItens, 100);
				}
			}
			else
			{
				ArrayCollection(dataProvider).addItem(this.includeItemFunction());
				selectedIndex = dataProvider.length - 1;
				setTimeout(this.editItens, 100);
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
				addItem();
			}
		}

		protected function excelKeyUpHandler(event:KeyboardEvent):void
		{
			var e:GridEvent;

			if (event.keyCode == Keyboard.DELETE)
			{
				if (selectedItem && selectedIndex < dataProvider.length)
				{
					e = new GridEvent(GridEvent.GRID_ITEM_REMOVED);
					e.rowIndex = selectedIndex;
					e.item = selectedItem;

					dataProvider.removeItemAt(selectedIndex);
					dispatchEvent(e);
				}
			}
		}

		private function editItens():void
		{
			startItemEditorSession(dataProviderLength - 1, 0);
		}

		private function itemEditEndHandler(event:GridItemEditorEvent):void
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
				this.addItem();
			}
		}
	}
}


