package br.pro.tiagolopes.business
{
	import br.pro.tiagolopes.events.AlertEvent;
	import br.pro.tiagolopes.events.GenericEvent;
	
	import com.asfusion.mate.events.Dispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ItemResponder;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.validators.Validator;
	
	public class GenericManager
	{
		[Bindable]
		public var item:Object;
		
		[Bindable]
		public var lista:ArrayCollection;
		
		protected var service:RemoteObject;
		
		protected var dispatcher:Dispatcher;
		
		private var _entity:String;
		
		protected function get entity():String
		{
			return _entity;
		}
		
		public function GenericManager(destination:String,entity:String)
		{
			service = new RemoteObject(destination);
			
			_entity = entity.replace(/[^\::]+::/,"").toUpperCase();
			dispatcher = new Dispatcher();
		}
		
		public function findAll(item:Object = null, properties:Array = null, validators:Array = null):void
		{
			if(isValid(validators))
			{
				CursorManager.setBusyCursor();
				
				var token:AsyncToken;
				if(item && properties)	token = service.findByExample(item,properties);
				else if(item)			token = service.findByExample(item);
				else 					token = service.findAll()
				token.addResponder(new ItemResponder(resultHandler,faultHandler));
			}
		}
		
		public function findById(itemId:int):AsyncToken
		{
			CursorManager.setBusyCursor();
			
			var token:AsyncToken = service.findById(itemId);
			token.addResponder(new ItemResponder(findById_resultHandler,faultHandler,token));
			return token;
		}
		
		public function save(item:Object,validators:Array):AsyncToken
		{
			if(isValid(validators))
			{
				CursorManager.setBusyCursor();
				
				var token:AsyncToken = service.save(item);
				token.addResponder(new ItemResponder(save_resultHandler,faultHandler,token));
				return token;
			}
			return null;
		}
		
		public function remove(item:Object):void
		{
			if(item)
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.CONFIRM,"Desejas realmente excluir os registro selecionado?",
					"Confirmar Exclusão",function(event:CloseEvent):void
					{
						if(event.detail == Alert.YES)
						{
							CursorManager.setBusyCursor();
							
							var token:AsyncToken = service.remove(item);
							token.addResponder(new ItemResponder(remove_resultHandler,faultHandler,item));
						}
					}));
			}
			else
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SELECTION_ERROR));
			}
		}
		
		public function edit(item:Object):AsyncToken
		{
			this.item = item;
			
			if(item && item.id)
			{
				var token:AsyncToken = findById(item.id);
				token.responders.pop();
				token.addResponder(new ItemResponder(edit_resultHandler,faultHandler,token));
				return token;
			}
			else if(item)
			{
				var e:GenericEvent = new GenericEvent(entity + "_stateChange");
				e.currentState = GenericEvent.EDIT_STATE;
				dispatcher.dispatchEvent(e);
			}
			else
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SELECTION_ERROR));
			}
			return null;
		}
		
		protected function isValid(validators:Array):Boolean
		{
			if(validators)
			{
				var inValid:Array = Validator.validateAll(validators);
				if(inValid.length)
				{
					UIComponent(Validator(ValidationResultEvent(inValid[0]).target).source).setFocus();
					return false;
				}
			}
			return true;
		}
		
		protected function resultHandler(event:ResultEvent, token:Object):void
		{
			lista = event.result as ArrayCollection;
			
			CursorManager.removeBusyCursor();
		}
		
		protected function findById_resultHandler(event:ResultEvent, token:Object):void
		{
			item = event.result;
			
			CursorManager.removeBusyCursor()
		}
		
		protected function save_resultHandler(event:ResultEvent, token:Object):void
		{
			if(event.result)
			{
				if(event.result is ArrayCollection)
					lista = event.result as ArrayCollection;
				else
					lista = new ArrayCollection([event.result]);
				
				CursorManager.removeBusyCursor();
				
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SUCCESS));
				
				var e:GenericEvent = new GenericEvent(entity + "_stateChange");
				e.currentState = GenericEvent.LIST_STATE;
				dispatcher.dispatchEvent(e);
			}
		}
		
		protected function remove_resultHandler(event:ResultEvent,token:Object):void
		{
			if(lista.contains(token))
			{
				lista.removeItemAt(lista.getItemIndex(token));
				lista.refresh();
			}
			
			CursorManager.removeBusyCursor()
			
			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SUCCESS));
		}
		
		protected function edit_resultHandler(event:ResultEvent,token:Object):void
		{
			var e:GenericEvent = new GenericEvent(entity + "_stateChange");
			e.currentState = GenericEvent.EDIT_STATE;
			dispatcher.dispatchEvent(e);
			
			CursorManager.removeBusyCursor();
			
			item = event.result;
			
		}
		
		protected function faultHandler(event:FaultEvent, token:Object):void
		{
			var mensagem:String = event.fault.faultString;
			
			mensagem = event.fault.faultString;
			
			if(event.fault.faultCode == "Server.Processing" && event.fault.rootCause && event.fault.rootCause.hasOwnProperty("message") && event.fault.rootCause.message)
			{
				mensagem = event.fault.rootCause.message;
			}
			
			CursorManager.removeBusyCursor();
			
			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.ERROR,mensagem));
		}
		
		protected function emptyHandler(event:Event = null, token:AsyncToken = null):void
		{
			//Não implementar nada neste método.
		}		
	}
}