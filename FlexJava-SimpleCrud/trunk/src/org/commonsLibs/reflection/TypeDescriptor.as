package org.commonsLibs.reflection
{
	import flash.net.getClassByAlias;
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public class TypeDescriptor
	{
		private var description:XML;
		private var domain:ApplicationDomain;
		
		public function TypeDescriptor(target:*,domain:ApplicationDomain)
		{
			description = describeType(target);
			this.domain = domain;
		}
		
		public function getClassName():String
		{
			return description.@name;
		}
		
		public function getMetadataTagByName(value:String):Metadata
		{
			for each (var metadata:Metadata in getMetadataTags()) {
				
				if(metadata.name == value)
				{
					return metadata;
				}
			}
			
			return null;
		}
		
		public function getMetadataTags():Array
		{
			var tags:Array = [];
			
			for each (var metadataNode:XML in description.metadata) {
				
				var metadata:Metadata = new Metadata();
				metadata.name = metadataNode.@name;
				metadata.atributes = [];
				
				for each (var argNode:XML in metadataNode.arg) {
					var atribute:Atributte = new Atributte();
					atribute.name = argNode.@key;
					atribute.value = argNode.@value;
					
					metadata.atributes.push(atribute);
				}
				
				tags.push(metadata)
			}
			
			return tags;
		}
		
		public function getPropertiesByMetadataTag(metadataTagName:String):Array
		{
			var tags:Array = [];
			
			for each(var accessorNode:XML in description.accessor)
			{
				var hasTag:Boolean = false;
				var property:Property = new Property();
				property.name = accessorNode.@name;
				property.typeString = accessorNode.@type;
				property.type = domain.getDefinition(accessorNode.@type) as Class;
				property.metadata = [];
				
				for each(var metadaNode:XML in accessorNode.metadata)
				{
					var metadata:Metadata = new Metadata();
					metadata.name = metadaNode.@name;
					property.metadata.push(metadata);
					
					if(metadata.name == metadataTagName)
					{
						hasTag = true;
					}
				}
				
				if(hasTag)
				{
					tags.push(property);
				}
				
			}
			
			return tags;
		}
	}
}