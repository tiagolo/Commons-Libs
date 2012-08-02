package org.commnoslibs.report.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.commonsLibs.swiz.events.AlertEvent;

	[Bindable]
	[Event(name = "cancel", type = "flash.events.Event")]
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	public class ReportUpload extends EventDispatcher
	{

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Static Property 
		//--------------------------------------

		public static const JASPER_FILE_FILTER:FileFilter = new FileFilter("Documento JasperReport", "*.jasper");

		public static const JRXML_FILE_FILTER:FileFilter = new FileFilter("Documento JasperReport", "*.jrxml");

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function ReportUpload()
		{
			jasperFileRef = new FileReference();
			jasperFileRef.addEventListener(IOErrorEvent.IO_ERROR, fileRef_IOErrorHandler);
			jasperFileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			jasperFileRef.addEventListener(Event.SELECT, jasperFileRef_selectHandler);
			jasperFileRef.addEventListener(Event.COMPLETE, jasperFileRef_completeHandler);
			jasperFileRef.addEventListener(Event.CANCEL, jasperFileRef_cancelHandler);

			jrxmlFileRef = new FileReference();
			jrxmlFileRef.addEventListener(IOErrorEvent.IO_ERROR, fileRef_IOErrorHandler);
			jrxmlFileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			jrxmlFileRef.addEventListener(Event.SELECT, jrxmlFileRef_selectHandler);
			jrxmlFileRef.addEventListener(Event.COMPLETE, jrxmlFileRef_completeHandler);
			jrxmlFileRef.addEventListener(Event.CANCEL, jrxmlFileRef_cancelHandler);

		}

		//--------------------------------------
		//   Property 
		//--------------------------------------

		public var jasperFileRef:FileReference;

		public var jasperName:String;

		public var jrxmlFileRef:FileReference;

		public var jrxmlName:String;

		private var isUploadRequestRunning:Boolean;

		private var urlRequest:URLRequest;

		//--------------------------------------
		//   Function 
		//--------------------------------------

		public function browse():void
		{
			jasperFileRef.browse([ReportUpload.JASPER_FILE_FILTER]);
		}

		public function isValid():Boolean
		{
			try
			{
				return (jasperFileRef.name.split(".jasper")[0] == jrxmlFileRef.name.split(".jrxml")[0]);
			}
			catch (e:Error)
			{
				trace(e);
			}
			return false;
		}

		public function upload(urlRequest:URLRequest):void
		{
			if (!isUploadRequestRunning)
			{
				this.urlRequest = urlRequest;

				jasperFileRef.upload(urlRequest);
			}
		}

		protected function localValidation():void
		{
			if (!isValid())
			{
				dispatchEvent(new AlertEvent(AlertEvent.CONFIRM, "Arquivos não são compatíveis, deseja selecionar arquivos .jasper e .jrxml novamente?", "Upload de relatórios", function(event:CloseEvent):void
				{
					if (event.detail == Alert.YES)
					{
						jasperFileRef.browse([ReportUpload.JASPER_FILE_FILTER]);
					}
				}));
			}
		}

		private function fileRef_IOErrorHandler(event:IOErrorEvent):void
		{
			dispatchEvent(new AlertEvent(AlertEvent.ERROR, event.toString(), event.type));
		}

		private function jasperFileRef_cancelHandler(event:Event):void
		{
			dispatchEvent(event);
		}

		private function jasperFileRef_completeHandler(event:Event):void
		{
			jrxmlFileRef.upload(urlRequest);
		}

		private function jasperFileRef_selectHandler(event:Event):void
		{
			jasperName = FileReference(event.currentTarget).name;

			dispatchEvent(new AlertEvent(AlertEvent.INFO,"Por favor, selecione o arquivo .jrxml", "Upload de subrelatórios", function(event:CloseEvent):void
			{
				jrxmlFileRef.browse([ReportUpload.JRXML_FILE_FILTER]);
			}));
		}

		private function jrxmlFileRef_cancelHandler(event:Event):void
		{
			localValidation();
		}

		private function jrxmlFileRef_completeHandler(event:Event):void
		{
			dispatchEvent(event);
		}

		private function jrxmlFileRef_selectHandler(event:Event):void
		{
			jrxmlName = FileReference(event.currentTarget).name;

			localValidation();
		}

		private function progressHandler(event:ProgressEvent):void
		{
			if (event.currentTarget == jrxmlFileRef)
			{
				event.bytesLoaded = event.bytesTotal + event.bytesLoaded;
			}
			event.bytesTotal = event.bytesTotal * 2;

			dispatchEvent(event);
		}
	}
}
