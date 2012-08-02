package com.app.model
{

	[Bindable]
	[RemoteClass(alias = "com.app.model.Pessoa")]
	[Event(name = "close", type = "flash.events.Event")]
	public class Pessoa
	{
		public var id:int;
		public var nascimento:Date;
		public var nome:String;

		public function toString():String
		{
			return "[Pessoa " + nome + "]";
		}
	}
}
