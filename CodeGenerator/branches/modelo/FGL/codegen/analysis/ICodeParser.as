package codegen.analysis
{
	
	public interface ICodeParser
	{
		
		/**
		 * 
		 * @param pCode raw string of the file code
		 * @return an array of PseudoClass Objects
		 * 
		 */
		function parseCode(pCode:String):Array;
		
	}
}