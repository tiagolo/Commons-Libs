package com.dehats.fcg.command
{
	import codegen.generation.GeneratedFile;
	
	import com.dehats.air.file.FileUtils;
	import com.dehats.fcg.model.ModelLocator;
	
	import flash.filesystem.File;
	
	public class FileCreatorCmdBase
	{
		public function createFile(pGenFile:GeneratedFile):File
		{
		
			var rootPath:String = ModelLocator.getInstance().generationFolder.nativePath;

			var f:File = FileUtils.createFileFromString(rootPath+"/"+pGenFile.destination+"/"+pGenFile.nameWithExt, pGenFile.code);
			
			return f;
		}
		
		public function createFileList(pList:Array):Array
		{
			var l:Array = [];
			for ( var i:int = 0 ; i < pList.length ; i++)
			{
				var gFile:GeneratedFile = pList[i];
				var f:File = createFile(gFile);
				l.push(f);
			}
			return l;
			
		}

	}
}