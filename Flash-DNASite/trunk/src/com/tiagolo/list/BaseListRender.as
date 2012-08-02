package com.tiagolo.list
{
	import com.tiagolo.display.CustomSprite;
	import com.tiagolo.utils.LoadingCircle;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;

	public class BaseListRender extends CustomSprite
	{
		public var dataPath:String;
		protected var _dataField:String = "imagem";
		protected var _data:Object;
		
		protected var loader:Loader = new Loader();
		protected var loadingCircle:LoadingCircle;
		
		protected var mascara:Sprite;
		
		public function BaseListRender()
		{
			super();
			addChild(loader);
			
			mascara = new Sprite();
			addChild(mascara);
			
			updateDisplayList(160,110);
		}
		
		public function get dataField():String
		{
			return _dataField;
		}

		public function set dataField(v:String):void
		{
			_dataField = v;
			if(data) data = data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			loader.load(new URLRequest(dataPath + "thumbs/" +value[dataField]));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCompleteHandler);
			addChild(loader);
			
			loadingCircle = new LoadingCircle();
			addChild(loadingCircle);
			updateDisplayList(width,height);
			
			buttonMode = true; 
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		protected function loaderCompleteHandler(event:Event):void
		{
			removeChild(loadingCircle);
			loader.filters = [new DropShadowFilter(2,128,0,.75,4,4,1,3)]
			loader.mask = mascara;
			updateDisplayList(width,height);
		} 
		
		override public function updateDisplayList(uWidth:Number, uHeight:Number):void
		{
			super.updateDisplayList(uWidth,uHeight);
			
			if(loader && contains(loader) && loadingCircle && !contains(loadingCircle))
			{
				loader.width = uWidth;
				loader.height = uHeight;
			}
			
			mascara.graphics.clear();
			mascara.graphics.beginFill(0,.1);
			mascara.graphics.drawRect(0,0,uWidth,uHeight);
			mascara.graphics.endFill();
			
			if(loadingCircle)
			{
				loadingCircle.x = uWidth/2;
				loadingCircle.y = uHeight/2;
			}
		}

	}
}