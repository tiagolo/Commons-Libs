package com.app.business
{
	import com.app.model.Pessoa;

	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.commonsLibs.swiz.business.GenericManager;
	import org.commonsLibs.swiz.business.abstract.AbstractManager;
	import org.swizframework.utils.services.ServiceHelper;

	public class SimpleCrudManager extends GenericManager
	{
		private var _entity:Object;

		public function get entity():Object
		{
			return _entity;
		}

		public function set entity(entity:Object):void
		{
			_entity = entity;
		}

		public function SimpleCrudManager()
		{
			super(null);
		}

		override public function find(item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = true):AsyncToken
		{
			return super.find(item, properties, validators, isPaged);
		}

		override public function save(item:Object, validators:Array):AsyncToken
		{
			return serviceHelper.executeServiceCall(service.save(item), save_resultHandler);
		}

		override protected function find_resultHandler(event:ResultEvent, target:Object, property:String):void
		{
			super.find_resultHandler(event, target, property);
			trace(event);
		}

		override protected function save_resultHandler(event:ResultEvent, token:Object):void
		{
			trace(event.message.body + " salvo com sucesso");
		}
	}
}


