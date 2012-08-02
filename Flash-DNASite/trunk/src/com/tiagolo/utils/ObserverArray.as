package com.tiagolo.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="change",type="flash.events.Event")]
	
	public class ObserverArray extends EventDispatcher
	{
		private var _sort:Array;
		private var array:Array;
		/**
		 * 
		 * 
		 */		
		public function ObserverArray()
		{
			super(this);
			array = new Array();
		}
		public function sort(...args):void
		{
			_sort = args;
			array.sort.apply(array,args);
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get length():int
		{
			return array.length;
		}
		/**
		 * 
		 * @param o
		 * 
		 */		
		public function addItem(o:Object):void
		{
			array.push(o);
			if(_sort) sort.apply(this,_sort);
			refresh();
		}
		public function removeAllItens():void
		{
			array = new Array();
			refresh();
		}
		/**
		 * 
		 * 
		 */		
		public function removeLastItem():void
		{
			array.pop();
			refresh();
		}
		/**
		 * 
		 * @param i
		 * 
		 */		
		public function removeItemAt(i:int):void
		{
			array.splice(i,1);
			refresh();
		}
		/**
		 * 
		 * @param o
		 * 
		 */		
		public function removeItem(o:Object):void
		{
			removeItemAt(getItemIndex(o));
		}
		
		/**
		 * 
		 * @param i
		 * @return 
		 * 
		 */		
		public function getItemAt(i:int):Object
		{
			return array[i];
		}
		/**
		 * 
		 * @param o
		 * @return 
		 * 
		 */		
		public function getItemIndex(o:Object):int
		{
			return array.indexOf(o);
		}
		/**
		 * 
		 * 
		 */		
		public function refresh():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * 
		 * @param callback
		 * @param thisObject
		 * 
		 */		
		public function foreach(callback:Function,thisObject:Object = null):void
		{
			array.forEach(callback,thisObject);
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		override public function toString():String
		{
			return array.join(",");
		}
	}
}