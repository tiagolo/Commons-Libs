package org.commnoslibs.report.business
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import mx.collections.ArrayCollection;
	import mx.events.CloseEvent;
	import org.commnoslibs.report.models.ReportUpload;
	import org.commonsLibs.swiz.business.abstract.AbstractManager;
	import org.commonsLibs.swiz.business.abstract.IAbstractManager;
	import org.commonsLibs.swiz.events.AlertEvent;

	[Bindable]
	[Event(name = "close", type = "mx.events.CloseEvent")]
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	public class UploadManager extends AbstractManager
	{

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function UploadManager()
		{
			super(null);
			reportUpload = new ReportUpload();
			reportUpload.addEventListener(ProgressEvent.PROGRESS, reportUpload_progressHandler);
			reportUpload.addEventListener(Event.COMPLETE, reportUpload_completeHandler);
		}

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Property 
		//--------------------------------------

		public var aplicacao:String;

		public var contextRoot:String;

		public var erroString:String;

		public var jasperName:String;

		public var jrxmlName:String;

		public var listSubReports:ArrayCollection = new ArrayCollection();

		public var reportUpload:ReportUpload;

		public var userId:int;

		private var uploadCurrentIndex:int;

		private var uploadTotalLength:int;

		//--------------------------------------
		//   Public Methods  
		//--------------------------------------

		public function browserJasper():void
		{
			reportUpload.jasperFileRef.browse([ReportUpload.JASPER_FILE_FILTER]);
		}

		public function browserJrxml():void
		{
			reportUpload.jrxmlFileRef.browse([ReportUpload.JRXML_FILE_FILTER]);
		}

		public function incluirSubreport():void
		{
			var subReportUpload:ReportUpload = new ReportUpload();
			subReportUpload.addEventListener(Event.CANCEL, reportUpload_cancelHandler);
			subReportUpload.addEventListener(Event.COMPLETE, reportUpload_completeHandler);
			subReportUpload.addEventListener(ProgressEvent.PROGRESS, reportUpload_progressHandler);
			subReportUpload.browse();

			listSubReports.addItem(subReportUpload);
		}

		public function removerSubreport(itens:Array):void
		{
			for (var i:int = itens.length - 1; i >= 0; i--)
			{
				listSubReports.removeItemAt(itens[i]);
			}
		}

		public function upload(validators:Array):void
		{
			if (isValid(validators))
			{
				if (reportUpload.isValid() && isSubReportsValid())
				{
					setProgress(0, 0);
					uploadTotalLength = listSubReports.length + 1;
					uploadCurrentIndex = 0;

					reportUpload.upload(getUrlRequest());
				}
				else
				{
					erroString = "Arquivos não são compatíveis, favor selecionar o arquivo .jrxml correspondente ao .jasper."
				}
			}
		}

		protected function getUrlRequest(isSubReport:Boolean = false):URLRequest
		{
			var params:URLVariables = new URLVariables();
			params.date = new Date();
			params.aplicacao = aplicacao;
			params.isSubReport = isSubReport;
			params.userId = userId;

			var request:URLRequest = new URLRequest(contextRoot + "/upload");
			request.method = URLRequestMethod.POST;
			request.data = params;

			return request;
		}

		//--------------------------------------
		//   Protected Methods  
		//--------------------------------------

		protected function isSubReportsValid():Boolean
		{
			for each (var rptUpload:ReportUpload in listSubReports)
			{
				if (!rptUpload.isValid())
				{
					return false;
				}
			}

			return true;
		}

		protected function setProgress(current:int, total:int):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, true, false, current, total));
		}

		//--------------------------------------
		//   Private Methods  
		//--------------------------------------

		private function reportUpload_cancelHandler(event:Event):void
		{
			listSubReports.removeItemAt(listSubReports.getItemIndex(event.currentTarget));
		}

		private function reportUpload_completeHandler(event:Event):void
		{
			if (uploadCurrentIndex < uploadTotalLength - 1)
			{
				uploadCurrentIndex += 1;
				var subReportUpload:ReportUpload = ReportUpload(listSubReports.getItemAt(uploadCurrentIndex - 1));
				subReportUpload.upload(getUrlRequest(true));
			}
			else
			{
				dispatchEvent(new AlertEvent(AlertEvent.SUCCESS, "Arquivos enviados com sucesso!", "Mensagem", dispatchEvent));
			}
		}

		private function reportUpload_progressHandler(event:ProgressEvent):void
		{
			var total:uint = event.bytesTotal * uploadTotalLength;
			var current:uint = (event.bytesTotal * uploadCurrentIndex) + event.bytesLoaded;

			setProgress(current, total);
		}
	}
}
