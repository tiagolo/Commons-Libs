package org.commonsLibs.containers
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
			if(selectedChild)
			return selectedChild.name
			return null;
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