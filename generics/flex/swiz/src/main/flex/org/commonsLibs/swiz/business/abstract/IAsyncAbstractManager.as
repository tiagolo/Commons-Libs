package org.commonsLibs.swiz.business.abstract
{
	import mx.rpc.AsyncToken;

	public interface IAsyncAbstractManager extends IAbstractManager
	{
//		function IAsyncAbstractManager(entity:*);

		function cancel():void;
		function count(item:Object = null, properties:Array = null, validators:Array = null):AsyncToken;
		function edit(item:Object):AsyncToken;
		function find(item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = true):AsyncToken;
		function findById(itemId:int):AsyncToken;
		function merge(item:Object, validators:Array):AsyncToken;
		function remove(item:Object):AsyncToken;
		function save(item:Object, validators:Array):AsyncToken;
		function update(item:Object, validators:Array):AsyncToken;
	}
}
