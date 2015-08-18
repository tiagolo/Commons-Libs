package org.commonsLibs.swiz.business
{
import flash.events.Event;
import flash.events.IEventDispatcher;

import mx.collections.ArrayCollection;
import mx.collections.AsyncListView;
import mx.collections.IList;
import mx.collections.ItemResponder;
import mx.collections.ListCollectionView;
import mx.collections.errors.ItemPendingError;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.rpc.AbstractService;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.commonsLibs.collections.PagedList;
import org.commonsLibs.core.cl_internal;
import org.commonsLibs.swiz.business.abstract.AbstractManager;
import org.commonsLibs.swiz.business.abstract.IAsyncAbstractManager;
import org.commonsLibs.swiz.events.AlertEvent;
import org.commonsLibs.swiz.events.GenericEvent;
import org.swizframework.utils.services.ServiceHelper;

use namespace cl_internal;

	/**
	 *
	 * @author Tiago Lopes da Costa
	 *
	 */
	[Bindable]
	public class GenericManager extends AbstractManager implements IAsyncAbstractManager
	{

		//----------------------------------------------------------
		//
		//
		//   Property 
		//
		//
		//----------------------------------------------------------

		//--------------------------------------
		//   Public Properties 
		//--------------------------------------

		public var currentState:String;

		public var dataProvider:IList;

		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		public var data:Object;

		public var service:AbstractService;

		[Inject]
		public var serviceHelper:ServiceHelper;

		public var totalRows:int;

		//--------------------------------------
		//   Protected Properties 
		//--------------------------------------

		protected var searchObject:Object;

		//----------------------------------------------------------
		//
		//
		//   Function 
		//
		//
		//----------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function GenericManager(entity:*)
		{
			super(entity);
		}

		//--------------------------------------
		//   Public Functions 
		//--------------------------------------

		public function cancel():void
		{
			currentState = GenericEvent.LIST_STATE;
		}

		public function count(item:Object = null, properties:Array = null, validators:Array = null):AsyncToken
		{
			var token:AsyncToken;

			if (!validators || isValid(validators))
			{
				if (item && properties)
					token = service.count(item, properties);
				else if (item)
					token = service.count(item);
				else
					token = service.count();
				token = serviceHelper.executeServiceCall(token, count_resultHandler);
			}

			return token;
		}

		public function createFailedItem(index:int, info:Object):Object
		{
			var str:String = "[" + index + " failed]";

			return str;
		}

		public function createPendingItem(index:int, ipe:ItemPendingError):Object
		{
			return {};
		}

		public function edit(item:Object):AsyncToken
		{
			this.data = item;

			if (item && item.id)
			{
				var token:AsyncToken = findById(item.id);
				token.responders.pop();
				token.addResponder(new ItemResponder(edit_resultHandler, faultHandler, token));
				return token;
			}
			else if (item)
			{
				currentState = GenericEvent.EDIT_STATE;
			}
			else
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SELECTION_ERROR));
			}
			return null;
		}

		/**
		 *
		 * @param item
		 * @param properties
		 * @param validators
		 * @param isPaged
		 * @return
		 *
		 */
		public function find(item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = true):AsyncToken
		{
			return findToTarget(this, "dataProvider", item, properties, validators, isPaged);
		}

		public function findToTarget(target:Object, property:String, item:Object = null, properties:Array = null, validators:Array = null, isPaged:Boolean = true):AsyncToken
		{
			var token:AsyncToken;

			searchObject = new Object();
			searchObject.item = item;
			searchObject.properties = properties;
			searchObject.validators = validators;
			searchObject.isPaged = isPaged;

			if (!validators || isValid(validators))
			{
				if (isPaged)
				{
					target[property] = new AsyncListView();
					AsyncListView(target[property]).createPendingItemFunction = createPendingItem;
					AsyncListView(target[property]).createFailedItemFunction = createFailedItem;

					token = serviceHelper.executeServiceCall(count(item, properties, validators), find_count_resultHandler, emptyHandler,[target,property]);
				}
				else
				{
					if (item && properties)
						token = service.find(item, properties);
					else if (item)
						token = service.find(item);
					else
						token = service.find()

					token = serviceHelper.executeServiceCall(token, find_resultHandler, emptyHandler, [target,property]);
				}
			}

			return token;
		}

		public function findById(itemId:int,target:Object = null, property:String = null):AsyncToken
		{
			if(!target || !property || !target.hasOwnProperty(property)){
				target = this;
				property = "data";
			}
			
			var token:AsyncToken = serviceHelper.executeServiceCall(service.findById(itemId),findById_resultHandler, emptyHandler, [target,property]);
			return token;
		}

		public function merge(item:Object, validators:Array):AsyncToken
		{
			if (isValid(validators))
			{
				var token:AsyncToken = service.merge(item);
				token.addResponder(new ItemResponder(save_resultHandler, faultHandler, token));
				return token;
			}
			return null;
		}

		public function remove(item:Object):AsyncToken
		{
			var token:AsyncToken;

			if (item)
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.CONFIRM, "Desejas realmente excluir os registro selecionado?", "Confirmar Exclusão", function(event:CloseEvent):void
				{
					if (event.detail == Alert.YES)
					{
						token = service.remove(item);
						token.addResponder(new ItemResponder(remove_resultHandler, faultHandler, item));
					}
				}));
			}
			else
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SELECTION_ERROR));
			}

			return token
		}

		public function saveOrUpdate(item:Object, validators:Array):AsyncToken
		{
			if (isValid(validators))
			{
				var token:AsyncToken = service.saveOrUpdate(item);
				token.addResponder(new ItemResponder(update_resultHandler, faultHandler, token));
				return token;
			}
			return null;
		}
		
		public function save(item:Object, validators:Array):AsyncToken
		{
			if (isValid(validators))
			{
				var token:AsyncToken = service.save(item);
				token.addResponder(new ItemResponder(save_resultHandler, faultHandler, token));
				return token;
			}
			return null;
		}

		public function update(item:Object, validators:Array):AsyncToken
		{
			if (isValid(validators))
			{
				var token:AsyncToken = service.update(item);
				token.addResponder(new ItemResponder(update_resultHandler, faultHandler, token));
				return token;
			}
			return null;
		}

		//--------------------------------------
		//   Protected Functions 
		//--------------------------------------

		protected function count_resultHandler(event:ResultEvent):void
		{
			totalRows = event.result as int;
		}

		protected function edit_resultHandler(event:ResultEvent, token:Object):void
		{
			currentState = GenericEvent.EDIT_STATE;

			data = event.result;
		}

		protected function emptyHandler(event:Event = null, token:AsyncToken = null):void
		{
			//Não implementar nada neste método.
		}

		protected function faultHandler(event:FaultEvent, token:Object = null):void
		{
			var mensagem:String = event.fault.faultString;

			mensagem = event.fault.faultString;

			if (event.fault.faultCode == "Server.Processing" && event.fault.rootCause && event.fault.rootCause.hasOwnProperty("message") && event.fault.rootCause.message)
			{
				mensagem = event.fault.rootCause.message;
			}

			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.ERROR, mensagem));
		}

		protected function findById_resultHandler(event:ResultEvent, target:Object, property:String):void
		{
			if(target && property && target.hasOwnProperty(property))
			{
				target[property] = event.result;
			}
		}

		protected function find_count_resultHandler(event:ResultEvent, target:Object, property:String):void
		{
			loadItems(null, 0, 20, event.result as int, target, property);
		}

		protected function find_paged_resultHandler(event:ResultEvent, list:IList, startIndex:uint, pageSize:uint, length:uint, target:Object = null, property:String = null):void
		{
			var pagedList:PagedList = list as PagedList;

			if (!pagedList)
			{
				pagedList = new PagedList(length);
				pagedList.loadItemsFunction = loadItems;

				if(target && property && target.hasOwnProperty(property) && target[property] is AsyncListView)
				{
					target[property].list = pagedList
				}
			}

			pagedList_populate(pagedList, pageList_getVector(event.result as IList), startIndex);
		}

		protected function find_resultHandler(event:ResultEvent, target:Object, property:String):void
		{
			target[property] = event.result as ArrayCollection;
			ArrayCollection(target[property]).refresh();
		}

		protected function loadItems(list:IList, startIndex:uint, pageSize:uint = 0, length:uint = 0, target:Object = null, property:String = null):void
		{
			var item:Object = searchObject.item;
			var properties:Array = searchObject.properties;
			
			var token:AsyncToken;
			
			if (item && properties)
				token = service.find(item, properties, startIndex, pageSize);
			else if (item)
				token = service.find(item, startIndex, pageSize);
			else
				token = service.find(startIndex, pageSize);
			
			serviceHelper.executeServiceCall(token, find_paged_resultHandler, null, [list, startIndex, pageSize, length, target, property]);
		}

		protected function pageList_getVector(value:IList):Vector.<Object>
		{
			var v:Vector.<Object> = new Vector.<Object>();

			for each (var i:Object in value)
			{
				v.push(i);
			}

			return v;
		}

		protected function pagedList_populate(list:PagedList, content:Vector.<Object>, start:uint):void
		{
			try
			{
				list.storeItemsAt(content, start);
			}
			catch (e:Error)
			{
				trace(e);
			}
		}

		protected function remove_resultHandler(event:ResultEvent, token:Object):void
		{
			if ((dataProvider is ListCollectionView || dataProvider is AsyncListView) && dataProvider.getItemIndex(token) > -1)
			{
				dataProvider.removeItemAt(dataProvider.getItemIndex(token));
				
				if(dataProvider is ListCollectionView)
					ListCollectionView(dataProvider).refresh();
			}

			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SUCCESS));
		}

		protected function save_resultHandler(event:ResultEvent, token:Object):void
		{
			if (event.result)
			{
				if (event.result is ArrayCollection)
				{
					dataProvider = event.result as ArrayCollection;
				}
				else
				{
					dataProvider = new ArrayCollection([event.result]);
				}

				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SUCCESS,null,null,function(event:CloseEvent):void{
					currentState = GenericEvent.LIST_STATE;
				}));

			}
		}

		protected function update_resultHandler(event:ResultEvent, token:Object):void
		{
			if (searchObject)
			{
				find(searchObject.item, searchObject.properties, searchObject.validators, searchObject.isPaged);

				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.SUCCESS,null,null,function(event:CloseEvent):void{
					currentState = GenericEvent.LIST_STATE;
				}));
			}
		}
	}
}


