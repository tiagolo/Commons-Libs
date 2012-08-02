package org.commonsLibs.swiz.business.abstract
{
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;

	public interface ISyncAbstractManager extends IAbstractManager
	{
		function cancel():void;
		function edit(item:Object):Object;
		function findAll(item:Object = null, properties:Array = null, validators:Array = null):ArrayCollection;
		function findById(itemId:int):Object;
		function remove(item:Object):Boolean;
		function save(item:Object, validators:Array):Object;
	}
}