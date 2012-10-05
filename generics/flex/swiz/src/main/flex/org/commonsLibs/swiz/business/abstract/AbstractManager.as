package org.commonsLibs.swiz.business.abstract
{
	import flash.net.getClassByAlias;
	import flash.utils.getQualifiedClassName;
	import mx.core.UIComponent;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;

	public class AbstractManager implements IAbstractManager
	{
		private var _entityClass:Class;

		protected function get entityClass():Class
		{
			return _entityClass;
		}
		private var _entityName:String;

		protected function get entityName():String
		{
			return _entityName;
		}

		public function AbstractManager(entity:*)
		{
			getEntity(entity);
		}

		public function isValid(validators:Array):Boolean
		{
			if (validators)
			{
				var inValid:Array = Validator.validateAll(validators);

				if (inValid.length)
				{
					UIComponent(Validator(ValidationResultEvent(inValid[0]).target).source).setFocus();
					return false;
				}
			}
			return true;
		}

		protected function getEntity(entity:*):void
		{
			if (entity is String)
			{
				_entityName = entity.replace(/[^\::]+::/, "").toUpperCase();
				_entityClass = getClassByAlias(entity);
			}
			else if (entity is Class)
			{
				_entityName = getQualifiedClassName(entity).replace(/[^\::]+::/, "").toUpperCase();
				_entityClass = entity;
			}
			else if (entity)
			{
				_entityName = getQualifiedClassName(entity).replace(/[^\::]+::/, "").toUpperCase();
				_entityClass = getClassByAlias(getQualifiedClassName(entity));
			}
		}
	}
}
