package com.tiagolo.text
{
	import com.tiagolo.display.CustomSprite;
	
	import fl.controls.UIScrollBar;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.xml.XMLDocument;
	
	public class TextStyleClass extends CustomSprite
	{
		private var my_txt:TextField;
		private var mySb:UIScrollBar;
		
		private var _width:Number;
		private var _height:Number;
		
		public function TextStyleClass ()
		{
			my_txt = new TextField();
			my_txt.multiline = true;
			my_txt.wordWrap = true;
			my_txt.condenseWhite = true;
			my_txt.border = false;
			my_txt.borderColor = 0xFFFFFF;
			addChild(my_txt);
			
			mySb = new UIScrollBar();
			mySb.direction = "vertical";
			setScroll();
			addChild(mySb);
		}

		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			my_txt.width = width - 10;
			my_txt.height = height;
			setScroll();
		}
		
		public function move(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function set embedding (txtEmbed:Boolean):void
		{
			my_txt.embedFonts = txtEmbed;
			my_txt.antiAliasType = "advanced";
		}
		
		public function set text(texto:String):void
		{
			my_txt.text = texto;
			setScroll();
		}
		
		public function get text():String
		{
			return my_txt.text;
		}
		
		public function set htmlText(texto:String):void
		{
			my_txt.htmlText = texto;
			setScroll();
		}
		
		public function get htmlText():String
		{
			return my_txt.htmlText;
		}
		
		public function set styleSheet(style:StyleSheet):void
		{
			if(!my_txt.styleSheet) my_txt.styleSheet = style;
		}
		
		public function get styleSheet():StyleSheet
		{
			return my_txt.styleSheet;
		}
		
		public function set border(bool:Boolean):void
		{
			my_txt.border = bool;			
		}
		
		public function get border():Boolean
		{
			return my_txt.border;
		}
		
		public function switchScroll():void
		{
			if(mySb.parent)
			{
				removeChild(mySb);
			}
			else
			{
				addChild(mySb);
			}
		}
		
		private function setScroll():void
		{
			mySb.setSize(_width, _height);
			mySb.move(my_txt.x + _width, my_txt.y);
			mySb.scrollTarget = my_txt;
			mySb.visible = false;
			if (my_txt.textHeight > _height)
			{
				mySb.visible = true;
			}
		}
	}
}