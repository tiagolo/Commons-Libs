package com.app.model
{
	import mx.collections.ArrayCollection;

	
	[RemoteClass(alias="com.app.model.Familia")]	
	[Bindable]
	public dynamic class Familia
	{
		public var id:Object;
		public var nome:String;
		public var items:ArrayCollection;
	}
}