package com.tiagolo.text
{
	import com.tiagolo.display.CustomSprite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class TextInput extends CustomSprite
	{
		public static const ENTER:String = "enter";
		
		private var labelStr:String = "Digite aqui seu login";
		private var value:String;
		private var color:Number;
		private var box:Sprite;
		private var iWidth:Number;
		private var iHeight:Number;
		private var _password:Boolean;
		
		public var _txt:TextField;
		
		public function TextInput()
		{
			super();
			
			_txt.text = label;
			_txt.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_txt.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			_txt.addEventListener(KeyboardEvent.KEY_UP, onChange);
			
			iWidth = _txt.width;
			iHeight = _txt.height;
			
			_color = 0xFFFFFF;
		}
		
		//Event Handlers
		private function onFocusIn(event:FocusEvent):void
		{
			
			if(value == "" || value == null)
			{
				_txt.text = "";
				if(password) _txt.displayAsPassword = true;
			}
		}
		
		private function onFocusOut(event:FocusEvent):void
		{
			if(value == "" || value == null)
			{
				_txt.displayAsPassword = false;
				_txt.text = label;
			}
		}
		
		private function onChange(event:KeyboardEvent):void
		{
			_value = _txt.text;
			if(event.keyCode == Keyboard.ENTER)
			{
				dispatchEvent(new Event(ENTER));
			}
		}
		
		//Getters & Setters
		public function set label(value:String):void
		{
			labelStr = value;
			onFocusOut(new FocusEvent(FocusEvent.FOCUS_OUT));
		}
		
		public function get label():String
		{
			return labelStr;
		}
		
		public function set _value(value:String):void
		{
			_txt.text = value;
			this.value = value;
		}
		
		public function get _value():String
		{
			return value;
		}
		
		public function set _color(value:Number):void
		{
			color = value;
			_txt.textColor = value;
			if(!box) box = new Sprite();
			box.graphics.clear();
			box.graphics.beginFill(value,.1);
			box.graphics.lineStyle(1,value,.5);
			box.graphics.drawRect(0,0,_width,_height);
			addChildAt(box,0);
		}
		
		public function get _color():Number
		{
			return color;
		}
		
		public function set _width(value:Number):void
		{
			iWidth = value;
			if(box)
			{
				_color = _color;
				_txt.width = value;
			}
		}
		
		public function get _width():Number
		{
			return iWidth;
		}
		
		public function set _height(value:Number):void
		{
			iHeight = value;
			if(box)
			{
				_color = _color;
				_txt.height = value;
			}
		}
		
		public function get _height():Number
		{
			return iHeight;
		}
		
		public function set password(value:Boolean):void
		{
			_password = true;
		}
		
		public function get password():Boolean
		{
			return _password;
		}
		
		public function set multiline(value:Boolean):void
		{
			_txt.multiline = value;
		}
		
		public function get multiline():Boolean
		{
			return _txt.multiline;
		}
		
		public function set wordWrap(value:Boolean):void
		{	
			_txt.wordWrap = value;
		}
		
		public function get wordWrap():Boolean
		{
			return _txt.wordWrap;
		}
		
	}
}