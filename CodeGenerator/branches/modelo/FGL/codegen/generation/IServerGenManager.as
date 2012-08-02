package codegen.generation
{
	import codegen.analysis.SQLDBData;

	/**
	 * 
	 * @author davidderaedt
	 * 
	 * Base interface for classes that manage server side (PHP, Java, ...) applications code generation
	 * 
	 */
	
	public interface IServerGenManager extends IGenManager
	{
		function addSQLDBData(pDBData:SQLDBData):Array;
	}
}