package org.commonsLibs.swiz.model
{
	
	public class Param
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public var key:String;
		
		public var value:String;
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function Param(key:String, value:String)
		{
			this.key = key;
			this.value = value;
		}
	}
}