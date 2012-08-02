package com.app.business
{
	import com.app.model.Familia;

	import mx.rpc.AsyncToken;

	import org.commonsLibs.swiz.business.GenericManager;

	public class FamiliaManager extends GenericManager
	{
		public function FamiliaManager()
		{
			super(Familia);
		}

		//--------------------------------------
		//   Function 
		//--------------------------------------

		[Mediate(event = "FamiliaEvent.CANCEL")]
		override public function cancel():void
		{
			super.cancel();
		}

		[Mediate(event = "FamiliaEvent.EDIT", properties = "familia")]
		override public function edit(item:Object):AsyncToken
		{
			return super.edit(item)
		}

		[Mediate(event = "FamiliaEvent.FIND_ALL", properties = "familia,properties,validators")]
		override public function find(item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = false):AsyncToken
		{
			return super.find(item, properties, []);
		}

		[Mediate(event = "FamiliaEvent.REMOVE", properties = "familia")]
		override public function remove(item:Object):AsyncToken
		{
			return super.remove(item);
		}

		[Mediate(event = "FamiliaEvent.SAVE", properties = "familia,validators")]
		override public function save(item:Object, validators:Array):AsyncToken
		{
			return super.save(item, validators);
		}
	}
}


