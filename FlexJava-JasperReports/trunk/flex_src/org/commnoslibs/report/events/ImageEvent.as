package org.commnoslibs.report.events
{
	import flash.events.Event;

	import org.commnoslibs.report.models.ImageFile;

	public class ImageEvent extends Event
	{
		public static const DOWNLOAD:String = "ImageEvent.DOWNLOAD";
		public static const FIND_ALL:String = "ImageEvent.FIND_ALL";
		public static const REMOVE:String = "ImageEvent.REMOVE";
		public static const UPLOAD:String = "ImageEvent.UPLOAD";

		public function ImageEvent(type:String, imageFile:ImageFile = null, bubbles:Boolean = true, cancelable:Boolean = false)
		{

			this.imageFile = imageFile;
			super(type, bubbles, cancelable);
		}

		public var imageFile:ImageFile;
	}
}


