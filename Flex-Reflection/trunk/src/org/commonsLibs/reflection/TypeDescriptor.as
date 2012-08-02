package org.commonsLibs.reflection
{
	import flash.net.getClassByAlias;
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class TypeDescriptor
	{
		public var className:String;
		public var description:XML;
		public var descriptionFactory:XML;
		private var domain:ApplicationDomain;

		public function TypeDescriptor(target:*, domain:ApplicationDomain)
		{

			trace("----");

			if (target is String)
				className = target
			else
				className = getQualifiedClassName(target);

			description = describeType(getDefinitionByName(className));
			descriptionFactory = description.factory[0]

			this.domain = domain;
		}

		public function getClassName():String
		{
			return description.@name;
		}

		public function getMetadataTagByName(value:String):Metadata
		{
			for each (var metadata:Metadata in getMetadataTags())
			{

				if (metadata.name == value)
				{
					return metadata;
				}
			}

			return null;
		}

		public function getMetadataTags():Array
		{
			var tags:Array = [];

			for each (var metadataNode:XML in descriptionFactory.metadata)
			{
				var metadata:Metadata = new Metadata(metadataNode);
				tags.push(metadata)
			}

			return tags;
		}

		public function getPropertiesByMetadataTag(metadataTagName:String):Array
		{
			var tags:Array = [];

			for each (var accessorNode:XML in description.accessor)
			{
				var hasTag:Boolean = false;
				var property:Property = new Property();
				property.name = accessorNode.@name;
				property.typeString = accessorNode.@type;
				property.type = domain.getDefinition(accessorNode.@type) as Class;
				property.metadata = [];

				for each (var metadaNode:XML in accessorNode.metadata)
				{
					var metadata:Metadata = new Metadata(metadaNode);
					property.metadata.push(metadata);

					if (metadata.name == metadataTagName)
					{
						hasTag = true;
					}
				}

				if (hasTag)
				{
					tags.push(property);
				}

			}

			return tags;
		}
	}
}
