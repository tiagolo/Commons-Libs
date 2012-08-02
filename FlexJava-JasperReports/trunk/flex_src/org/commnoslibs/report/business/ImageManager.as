package org.commnoslibs.report.business
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.AbstractService;
	import mx.rpc.events.ResultEvent;
	import org.commnoslibs.report.models.ImageFile;
	import org.commonsLibs.swiz.events.AlertEvent;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.utils.services.ServiceHelper;

	public class ImageManager extends AbstractController
	{

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Property 
		//--------------------------------------

		[Bindable]
		public var contextRoot:String;

		[Bindable]
		public var image:String;

		[Bindable]
		public var lista:ArrayCollection;

		[Bindable]
		public var service:AbstractService;

		[Inject]
		public var serviceHelper:ServiceHelper;

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Function 
		//--------------------------------------

		[Mediate(event = "ImageEvent.DOWNLOAD", properties = "imageFile")]
		public function download(imageFile:ImageFile):void
		{
			var request:URLRequest = new URLRequest(contextRoot + "/download/" + imageFile.name);

			request.data = new URLVariables();
			request.data["filePath"] = imageFile.path;
			request.method = URLRequestMethod.POST;

			navigateToURL(request);
		}

		[PostConstruct]
		[Mediate(event = "ImageEvent.FIND_ALL")]
		public function findImages():void
		{
			serviceHelper.executeServiceCall(service.findImages(), findImages_resultHandler);
		}

		[Mediate(event = "ImageEvent.REMOVE", properties = "imageFile")]
		public function remove(imageFile:ImageFile):void
		{
			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.CONFIRM, "Deseja realmente remover a imagem selecionada?\n", "Remoção de imagem", function(event:CloseEvent):void
			{
				if (event.detail == Alert.YES)
				{
					serviceHelper.executeServiceCall(service.remover(imageFile), remove_resultHandler);
				}
			}));
		}

		[Mediate(event = "ImageEvent.UPLOAD")]
		public function upload():void
		{
			var fileReference:FileReference = new FileReference();
			fileReference.addEventListener(Event.COMPLETE, fileReference_completeHandler);
			fileReference.addEventListener(Event.SELECT, fileRefence_selectHandler);
			fileReference.browse([new FileFilter("Imagens(*.png,*.jpg,*.gif)", "*.png;*.jpg;*.gif")]);
		}

		private function fileRefence_selectHandler(event:Event):void
		{
			var imageFile:ImageFile = new ImageFile();
			imageFile.fileReference = event.target as FileReference;
			imageFile.name = imageFile.fileReference.name;

			var params:URLVariables = new URLVariables();
			params.date = new Date();
			params.aplicacao = "."

			var request:URLRequest = new URLRequest(contextRoot + "/upload");
			request.method = URLRequestMethod.POST;
			request.data = params;

			imageFile.fileReference.upload(request);

			lista.addItem(imageFile);
			lista.refresh();
		}

		private function fileReference_completeHandler(event:Event):void
		{
			findImages();
		}

		private function findImages_resultHandler(event:ResultEvent):void
		{
			lista = event.result as ArrayCollection;
			getImageFileBytes();
		}

		private function getImageFileBytes():void
		{
			for each (var imageFile:ImageFile in lista)
			{
				if (!imageFile.bitmapData)
				{
					serviceHelper.executeServiceCall(service.getImageFileBytes(imageFile), getImageFileBytes_resultHandler, null, [imageFile]);
					break;
				}
			}
		}

		private function getImageFileBytes_resultHandler(event:ResultEvent, imageFile:ImageFile):void
		{
			imageFile.bitmapData = ImageFile(event.result).bitmapData;
			getImageFileBytes();
			lista.refresh();
		}

		private function remove_resultHandler(event:ResultEvent):void
		{
			findImages();
		}
	}
}
