package org.commonsLibs.reflection
{

	public class Metadata
	{
		[ArrayElementType("org.commonsLibs.reflection.Atributte")]
		public var atributes:Array;
		public var name:String;
		private var description:Object;

		public function Metadata(description:XML)
		{
			this.description = description;
			this.name = description.@name;
			this.atributes = [];

			for each (var argNode:XML in description.arg)
			{
				var atribute:Atributte = new Atributte();
				atribute.name = argNode.@key;
				atribute.value = argNode.@value;

				this.atributes.push(atribute);
			}

		}

		public function getAtributeValueByName(value:String):*
		{
			for each (var atribute:Atributte in atributes)
			{

				if (atribute.name == value)
				{
					return atribute.value;
				}
			}

			return null;
		}

		public function toString():String
		{
			return "[Metadata " + name + "]"
		}
	}
}
