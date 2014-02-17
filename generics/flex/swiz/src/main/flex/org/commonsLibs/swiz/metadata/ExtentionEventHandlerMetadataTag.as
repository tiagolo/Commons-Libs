package org.commonsLibs.swiz.metadata
{
	import org.swizframework.metadata.EventHandlerMetadataTag;
	
	public class ExtentionEventHandlerMetadataTag extends EventHandlerMetadataTag
	{
		protected var _handler:Function;
		
		public function get handler():Function
		{
			return _handler;
		}

		public function set handler(value:Function):void
		{
			_handler = value;
		}
		
		public function ExtentionEventHandlerMetadataTag()
		{
			super();
		}
	}
}