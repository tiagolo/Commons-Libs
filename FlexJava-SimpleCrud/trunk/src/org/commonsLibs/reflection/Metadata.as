package org.commonsLibs.reflection
{
	public class Metadata
	{
		public var name:String;	
		[ArrayElementType("org.commonsLibs.reflection.Atributte")]
		public var atributes:Array;
		
		public function getAtributeValueByName(value:String):*
		{
			for each (var atribute:Atributte in atributes) {
				
				if(atribute.name == value)
				{
					return atribute.value;
				}
			}
			
			return null;
		}
	}
}