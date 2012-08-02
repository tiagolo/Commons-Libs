package com.rd.widget.cascadelist
{
    import flash.events.Event;
    import flash.events.FocusEvent;
    
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import mx.controls.*;
    import mx.controls.treeClasses.DefaultDataDescriptor;
    import mx.controls.treeClasses.ITreeDataDescriptor;

	
	/**
	 *  Dispatched when the CascadeList selection has been updated.
	 *
	 *  @eventType com.rd.widget.cascadelist.CascadeListItemSelectedEvent
	 */
    [Event(name="listItemSelected", type="com.rd.widget.cascadelist.CascadeListItemSelectedEvent")]	


	/**
	 * Cascade list widget that display tree like data structures.
	 * 
	 *	To use:
	 *  1) pass data (for now tree like structure with two props 'label' and 'children') through 'dataProvider' property. 
	 *  2) define event handler for 'CascadeListItemSelected' to receive selected item. 
	 * 
	 */ 
    public class CascadeList extends Canvas {

		private var _selectedItem:Object
		private var _selectedList:DynamicList;
		private var _editable:Boolean;
		
		/* Style name for a list components */
		private var _listStyleName:String;

        /* Initial number of cascade list levels */    
        private var _numberOfLevels:Number = 2;
       
        /* Data provider */
        private var _data:Object;
        private var _dataDescriptor:ITreeDataDescriptor = new DefaultDataDescriptor();        
        
        private var hBox:HBox;


        public function CascadeList() 
        {
            super();
        }

        override protected function createChildren():void 
        {
            super.createChildren();

 			hBox = new HBox();
 			hBox.setStyle("horizontalGap", 0);
			hBox.percentHeight = 100;
			hBox.percentWidth = 100;
			hBox.verticalScrollPolicy = "off"
			
            addChild(hBox);
        }
        
        override protected function measure():void
        {
        	this.minHeight = 100;
        }
        
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);            
            
			hBox.setActualSize(this.width, this.height);
        }  
		
        private function initData():void 
        {
			hBox.removeAllChildren();
			     	
			for (var i:int=0; i< _numberOfLevels; i++) 
			{
	            hBox.addChild(createListControl(i));
			}
			
			var firstLevelData:Object = _dataDescriptor.getChildren(_data);
			DynamicList(hBox.getChildAt(0)).dataProvider = firstLevelData;
        }
        
        private function createListControl(name:int):DynamicList
        {
            var list:DynamicList = new DynamicList();
            list.name = String(name);
            list.addEventListener("change", onItemSelectedEvent);
            
            list.percentWidth = 100;
            list.minWidth = 100;
            list.percentHeight = 100;
			list.setStyle("paddingRight", "0");	  
			list.allowMultipleSelection = true;  
			list.labelFunction = labelFunction;  
			list.editable = editable;
			
			list.styleName = _listStyleName;
            list.addEventListener(FocusEvent.FOCUS_IN,list_focusInHandler);
			
            return list;        	
        }
        
        private function labelFunction(item:Object):String
        {
			if (item.hasOwnProperty("children"))
			{
				if (item.children.length >= 0) 
				{
					return item.label + " (" + item.children.length + ")";
				}
			} 
			return item.label;
        }
        
        
        private function updateLevelDataProvider(nextLevel:int, node:Object):void
        {
        	var numberOfChildren:int = hBox.getChildren().length; 
        	for (var i:int = nextLevel; i < numberOfChildren; i++)
        	{
        		hBox.removeChildAt(nextLevel);	
        	}
        	
			var nextLevelChildren:Object = _dataDescriptor.getChildren(node);
			 	
			if (nextLevelChildren != null)
			{
				var currentList:DynamicList = createListControl(nextLevel);	
				if (nextLevelChildren != null && nextLevelChildren.length > 0) 				
				{
					currentList.dataProvider = nextLevelChildren;
				}
				if (hBox.getChildren().length > nextLevel) 
				{
					hBox.removeChildAt(nextLevel);
				}
				hBox.addChildAt(currentList, nextLevel);
			} 
			
			callLater(function():void {hBox.horizontalScrollPosition += hBox.getChildAt(nextLevel -1).width; });			
        }
        
        private function moveScrollBar():void
        {
			hBox.horizontalScrollPosition += 100;        	
        }
        
        private function createNextLevel(node:Object, nextLevel:int):void
        {
			createListControl(nextLevel);
        }
        
		/* ====================
		*    EVENT HANDLERS 
		*===================== */
		
		private function list_focusInHandler(event:FocusEvent):void
		{
			selectedList = event.target as DynamicList;
		}
		
        private function onItemSelectedEvent(event:Event):void 
        {
        	var nextLevel:int = int(event.currentTarget.name) + 1;
			var node:Object = event.currentTarget.selectedItem;
        	
			updateLevelDataProvider(nextLevel, node);
			
			selectedItem = event.currentTarget.selectedItem;
			
			var itemSelectedEvent:CascadeListItemSelectedEvent = new CascadeListItemSelectedEvent(CascadeListItemSelectedEvent.TYPE);
			itemSelectedEvent.currentSelectedItem = event.currentTarget.selectedItem;
            dispatchEvent(itemSelectedEvent);			
        }
		
		/* ====================
		 *  GETTERS & SETTERS 
		 *===================== */
		
        public function set initialNumberOfLevels(n:Number):void 
        {
            _numberOfLevels = n;
        }
        
        public function get initialNumberOfLevels():Number 
        {
            return _numberOfLevels;
        }  
        
        public function set dataProvider(data:Object):void 
        {
        	_data = data;
        	initData();
            invalidateDisplayList();
            dispatchEvent(new Event("dataChanged"));
        }
        
        [Bindable(event="dataChanged")]
        public function get dataProvider():Object 
        {
            return _data;
        }    
                        
        public function set listStyleName(data:String):void 
        {
        	_listStyleName = data;
        	initData();
            invalidateDisplayList();
        }
        
        public function get listStyleName():String 
        {
            return _listStyleName;
        }

		public function get selectedItem():Object
		{
			return _selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
			_selectedItem = value;
		}

		public function get selectedList():DynamicList
		{
			return _selectedList;
		}

		public function set selectedList(value:DynamicList):void
		{
			_selectedList = value;
		}

		public function get editable():Boolean
		{
			return _editable;
		}

		public function set editable(value:Boolean):void
		{
			_editable = value;
			invalidateProperties();
		}


   }
}