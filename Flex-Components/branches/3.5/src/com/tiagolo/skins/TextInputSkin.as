package com.tiagolo.skins
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import mx.controls.TextInput;
	import mx.skins.Border;
	import mx.skins.ProgrammaticSkin;
	import mx.styles.StyleManager;

	public class TextInputSkin extends ProgrammaticSkin
	{
		private var border:Sprite;
		private var background:Sprite;
		
		public function TextInputSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(uW:Number, uH:Number):void
		{
			var p:TextInput;
			var m:Matrix = new Matrix();
			var color1:uint = 0x030303;
			var color2:uint = 0xE6E6E6;
			var color3:uint = 0xB9B9B9;
			
			
			if(parent && parent is TextInput)
			{
				p = TextInput(parent);
				p.height = 29;
				if(p.errorString != " " && p.errorString != "")
				{
//					var ct:ColorTransform = new ColorTransform();
//					ct.color = p.getStyle("errorColor") as int;
//					transform.colorTransform = ct;
					color1 = p.getStyle("errorColor") as int;
					color3 = p.getStyle("errorColor") as int;
				}
//				else
//					transform.colorTransform = new ColorTransform();
			}
			
			
			m.createGradientBox(uW,uH,Math.PI/2,0,0);
			graphics.clear();
			
			graphics.beginFill(getStyle("backgroundColor"),getStyle("backgroundAlpha"));
			graphics.drawRect(2,2,uW-2,uH-2);
			graphics.endFill();
			
			graphics.lineGradientStyle(GradientType.LINEAR,[0xFFFFFF,color2],[.75,.2],[0,255],m);
			graphics.drawRect(0,0,uW,uH);
			graphics.lineStyle(1,color3,1);
			graphics.drawRect(1,1,uW-3,uH-3);
			graphics.lineStyle(1,0,.11);
			graphics.lineStyle(1,color1,.1);
			graphics.moveTo(3,2);
			graphics.lineTo(uW-3,2);
			graphics.lineGradientStyle(GradientType.LINEAR,[color1,color2],[.1,0],[0,255],m);
			graphics.moveTo(2,2);
			graphics.lineTo(2,uH-3);
			graphics.moveTo(uW-3,2);
			graphics.lineTo(uW-3,uH-3);
			graphics.lineStyle(1,color1,.1);
			graphics.moveTo(3,3);
			graphics.lineTo(4,4);
			graphics.moveTo(uW-3,3);
			graphics.lineTo(uW-4,4);
			
		}
	}
}