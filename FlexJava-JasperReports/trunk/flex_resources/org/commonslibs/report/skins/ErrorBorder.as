package org.commonslibs.report.skins
{
	import flash.display.DisplayObjectContainer;
	import mx.core.Container;
	import mx.skins.halo.HaloBorder;

	public class ErrorBorder extends HaloBorder
	{

		public function ErrorBorder()
		{
			super();
		}

		public var oldBorderStyle:String;

		override public function styleChanged(styleProp:String):void
		{
			if (parent && parent is Container && parent.hasOwnProperty("errorString") && parent["errorString"])
			{
				if (!oldBorderStyle)
				{
					oldBorderStyle = getStyle("borderStyle");
					Container(parent).setStyle("borderStyle", "solid");
				}

			}
			else if (oldBorderStyle)
			{
				Container(parent).setStyle("borderStyle", oldBorderStyle);
				oldBorderStyle = null;
			}

			super.styleChanged(styleProp);
		}
	}
}
