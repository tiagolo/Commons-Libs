package com.dehats.air.file
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class FileUtils
	{
		
		
		public static function getFileString(file:File, pEncoding:String="utf-8"):String
		{
			//var file:File = File.desktopDirectory.resolvePath(pPath);
			
			var stream:FileStream = new FileStream();
			
			stream.open(file, FileMode.READ);
			
			var str:String = stream.readMultiByte(stream.bytesAvailable, pEncoding);
			
			stream.close();
			
			return str;
		}
		
		
		public static function createFileFromString(pPath:String, pText:String, pEncoding:String="utf-8"):File
		{
			var file:File =  new File(pPath);			
			writeTextInFile(file, pText, pEncoding);			
			return file;
		}
		
		public static function createTmpFileFromString(pName:String, pText:String, pEncoding:String="utf-8"):File
		{

			var file:File = File.createTempDirectory().resolvePath(pName);
			writeTextInFile(file, pText, pEncoding);
			return file;

		}	
		
		public static function writeTextInFile(pFile:File, pText:String, pEncoding:String="utf-8"):void
		{
			// Replace line ending character with the appropriated one
			var t:String = pText.replace(/[\r|\n]/g, File.lineEnding);			
			var stream:FileStream = new FileStream();			
			stream.open(pFile, FileMode.WRITE);			
			stream.writeMultiByte(t, pEncoding);			
			stream.close();			
		}
		
		public static function getOrMoveFile(pDirPath:String, pParentDir:File=null):File
		{
		
			if(pParentDir==null) pParentDir = File.applicationStorageDirectory;
			
			var f:File = pParentDir.resolvePath(pDirPath);
			
			if(!f.exists) { 
				
				trace("Unable to find "+pDirPath+", copying from applicationDirectory to " + pParentDir.nativePath);
				
				var f2:File = File.applicationDirectory.resolvePath(pDirPath); 
				
				if( ! f2.exists ) return null ;//Alert.show("Unable to find file or directory : "+ pDirPath, "File not found");
				
				f2.copyTo(pParentDir.resolvePath(pDirPath));
				 
				return f2;
			}
			else return f;
			
		}

	}
}