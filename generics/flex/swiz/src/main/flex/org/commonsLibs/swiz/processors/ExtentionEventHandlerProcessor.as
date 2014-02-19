package org.commonsLibs.swiz.processors
{
	import org.commonsLibs.swiz.metadata.ExtentionEventHandlerMetadataTag;
	import org.swizframework.core.Bean;
	import org.swizframework.factories.MetadataHostFactory;
	import org.swizframework.processors.EventHandlerProcessor;
	import org.swizframework.processors.ProcessorPriority;
	import org.swizframework.reflection.IMetadataHost;
	import org.swizframework.reflection.IMetadataTag;

	public class ExtentionEventHandlerProcessor extends EventHandlerProcessor
	{
		public function ExtentionEventHandlerProcessor()
		{		
			this._metadataNames = ["ExtentionEventHandler"];
			this._metadataClass = ExtentionEventHandlerMetadataTag;
		}
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 *
		 */
		override public function get priority():int
		{
			return ProcessorPriority.DEFAULT;
		}
		
		// ========================================
		// public methods
		// ========================================
		
		/**
		 * @inheritDoc
		 */
		override public function setUpMetadataTag( metadataTag:IMetadataTag, bean:Bean ):void
		{
			var eventHandlerTag:ExtentionEventHandlerMetadataTag = metadataTag as ExtentionEventHandlerMetadataTag;
			
			var hostMethods:XMLList = bean.typeDescriptor.description..method;
			for each(var hostMethod:XML in hostMethods)
			{
				if(hostMethod.@name == eventHandlerTag.handler)
				{
					var host:IMetadataHost = MetadataHostFactory.getMetadataHost( hostMethod, bean.typeDescriptor.domain);
					eventHandlerTag.host = host;
				}
			}
			
			super.setUpMetadataTag(metadataTag, bean);
		}
	}
}