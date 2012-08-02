package org.commnoslibs.report.models
{
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	[Bindable]
	[RemoteClass(alias="br.com.mv.report.model.ImageFile")]
	public class ImageFile
	{
		public var name:String;
		public var path:String;
		public var bitmapData:ByteArray;
		public var fileReference:FileReference;
	}
}