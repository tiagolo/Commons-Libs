package com.dehats.fcg.view
{
	public class OperationData
	{
		
		public var operationClass:Class;
		public var name:String;
		public var description:String;
		
		public function OperationData(pClass:Class, pName:String, pDescription:String)
		{
			operationClass = pClass;
			name = pName;
			description = pDescription;
		}

	}
}