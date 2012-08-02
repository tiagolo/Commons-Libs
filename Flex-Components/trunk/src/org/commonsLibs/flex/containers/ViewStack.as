package org.commonsLibs.flex.containers
{
	
	import mx.containers.ViewStack;
	import mx.core.INavigatorContent;
	
	public class ViewStack extends mx.containers.ViewStack
	{
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function ViewStack()
		{
			super();
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		[Bindable]
		public function get selectedChildByName():String
		{
			return selectedChild.name
		}
		
		public function set selectedChildByName(value:String):void
		{
			if (value)
			{
				selectedChild = getChildByName(value) as INavigatorContent;
			}
		}
	}
}