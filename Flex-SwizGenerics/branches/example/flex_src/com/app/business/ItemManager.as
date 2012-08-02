package com.app.business
{
	import com.app.model.Item;

	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.commonsLibs.swiz.business.GenericManager;

	public class ItemManager extends GenericManager
	{
		[Bindable]
		public var listaAudit:ArrayCollection;

		public function ItemManager()
		{
			super(Item);
		}

		//--------------------------------------
		//   Function 
		//--------------------------------------
		[Mediate(event="ItemEvent.FIND_AUDIT",properties="item")]
		public function findAuditByID(item:Object):void
		{
			serviceHelper.executeServiceCall(service.findAuditByID(item),findAudit_resultHandler,faultHandler);
		}

		private function findAudit_resultHandler(event:ResultEvent):void
		{
			listaAudit = event.result as ArrayCollection;
			listaAudit.refresh();
		}

		[Mediate(event="ItemEvent.CANCEL")]
		override public function cancel():void
		{
			super.cancel();
		}

		[Mediate(event="ItemEvent.EDIT", properties="item")]
		override public function edit(item:Object):AsyncToken
		{
			if(item.id)
				findAuditByID(item);

			return super.edit(item);
		}

		[Mediate(event="ItemEvent.FIND_ALL", properties="item,properties,validators")]
		override public function find(item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = false):AsyncToken
		{
			return super.find(item, properties);
		}

		[Mediate(event="ItemEvent.REMOVE", properties="item")]
		override public function remove(item:Object):AsyncToken
		{
			return super.remove(item);
		}

		[Mediate(event="ItemEvent.SAVE", properties="item,validators")]
		override public function save(item:Object, validators:Array):AsyncToken
		{
			return super.save(item, validators);
		}

		override protected function edit_resultHandler(event:ResultEvent, token:Object):void
		{
			super.edit_resultHandler(event, token);
		}
	}
}

