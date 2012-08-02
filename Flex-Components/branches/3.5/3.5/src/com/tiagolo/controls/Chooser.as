package com.tiagolo.controls
{
	import com.hillelcoren.components.AutoComplete;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ItemResponder;
	import mx.collections.ListCollectionView;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	public class Chooser extends AutoComplete
	{
		public var destination:String;
		public var operation:String;
		public var params:Array;
		
		private var _remote:RemoteObject;
		private var _isSearching:Boolean;
		
		override public function Chooser()
		{
			super();
			
			_remote = new RemoteObject();
			addEventListener(SEARCH_CHANGE,searchChangeHandler);
		}
		
		protected function searchChangeHandler(event:Event):void
		{
			if(textInput.text.length > 2)
			{
				if(destination && operation && !_isSearching)
				{
					var _a:AsyncToken;
					
					_isSearching = true;
					_remote.destination = destination;
					
					if(params)
					{
						var _o:AbstractOperation = _remote.getOperation(operation)
						_o.arguments = params.concat(searchText).reverse();
						_a = _o.send();
					}	
					else
					{
						_a = _remote.getOperation(operation).send(text);
					}
					
					_a.addResponder(new ItemResponder(resultHandler,faultHandler,_a));
					cursorManager.setBusyCursor();
				}
			}
		} 
		
		private function resultHandler(event:ResultEvent,token:AsyncToken):void
		{
			cursorManager.removeBusyCursor();
			
			if(event.result is ListCollectionView)
				dataProvider = event.result as ListCollectionView;
			else
				dataProvider = new ArrayCollection([event.result]);
			
			search();
			_isSearching = false;
		}
		
		private function faultHandler(event:FaultEvent,token:AsyncToken):void
		{
			cursorManager.removeBusyCursor();
			_isSearching = false;
		}
	}
}