package org.commonsLibs.swiz.metadata
{
	import org.swizframework.metadata.EventHandlerMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	
	public class ExtentionEventHandlerMetadataTag extends EventHandlerMetadataTag
	{
		protected var _handler:String;
		
		public function get handler():String
		{
			return _handler;
		}

		public function set handler(value:String):void
		{
			_handler = value;
		}
		
		public function ExtentionEventHandlerMetadataTag()
		{
			super();
		}
		
		override public function copyFrom(metadataTag:IMetadataTag):void
		{
			super.copyFrom(metadataTag);
			
			// event is the default attribute
			// [EventHandler( "someEvent" )] == [EventHandler( event="someEvent" )]
			if( hasArg( "handler" ) )
				_handler = getArg( "handler" ).value;
		}
	}
}