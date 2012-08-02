package org.commonsLibs.reflection
{
	[Bindable]
	public class Property
	{
		public var name:String;
		
		public var type:Class;
		
		public var typeString:String
		
		public var owner:Class;
		
		[ArrayElementType("org.commonsLibs.reflection.Metadata")]
		public var metadata:Array;
		
		public function getMetadataTag(value:String):Metadata
		{
			for each (var metadataTag:Metadata in metadata) {
				
				if(metadataTag.name == value)
				{
					return metadataTag;
				}
			}
			
			return null;
		}
		
		public function toString() : String {
			return "[org.commonsLibs.reflection.Property :: "+name+"]";
		}
		
		public function equals(property:Property):Boolean
		{
			if(property && property.name == name && property.type == type && property.owner == owner)
			{
				return true;
			}
			
			return false;
		}
	}
}