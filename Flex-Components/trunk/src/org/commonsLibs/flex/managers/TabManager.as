package org.commonsLibs.flex.managers
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.TabNavigator;
	import mx.core.INavigatorContent;
	
	public class TabManager
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public var _tabNavigator:TabNavigator;
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function openTab(clazz:Class):void
		{
			var length:int = _tabNavigator.getChildren().length;
			
			for (var i:int = 0; i < length; i++)
			{
				var tab:DisplayObject = _tabNavigator.getChildAt(i);
				
				if (tab is clazz)
				{
					_tabNavigator.selectedChild = tab as INavigatorContent;
					return;
				}
			}
			_tabNavigator.selectedChild = _tabNavigator.addChild(new clazz()) as INavigatorContent;
		}
		
		public function closeTab(clazz:Class):void
		{
			for (var i:int = _tabNavigator.getChildren().length - 1; i >= 0; i--) 
			{
				var tab:DisplayObject = _tabNavigator.getChildAt(i);
				
				if(tab is clazz)
				{
					_tabNavigator.removeChildAt(i);
				}
			}
			
		}
		
		public function set tabNavigator(tabNavigator:TabNavigator):void
		{
			_tabNavigator = tabNavigator;
			_tabNavigator.addEventListener(Event.CLOSE, function(event:Event):void
			{
				_tabNavigator.removeChild(_tabNavigator.selectedChild as DisplayObject);
			}, false, 0, true);
		}
	}
}