package com.rd.widget.cascadelist
{
	import flash.events.Event;

	/**
	 *  The CascadeListItemSelected class represents event objects specific to cascade list, 
	 *  and generated when item at any level is selected.
	 *
	 */
	public class CascadeListItemSelectedEvent extends Event
	{
		public static var TYPE : String = "listItemSelected";		
		public var currentSelectedItem:Object;		
		
		public function CascadeListItemSelectedEvent(type:String)
		{
			super(type);
		}
		

	}
}