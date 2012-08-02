package org.commonsLibs.flex.utils
{
	public class StringUtil
	{
		public static const STR_PAD_LEFT:int = 0;
		public static const STR_PAD_RIGHT:int = 1;
		
		public static function strPad(texto:String, total:int, valPreenche:String, alinhamento:int):String
		{
			var totalCars:int = total - texto.length;
			
			for(var i:int = 0; i < totalCars; i++)
			{
				if(alinhamento == STR_PAD_LEFT)
					texto = valPreenche + texto;
				else
					if(alinhamento == STR_PAD_RIGHT)
						texto = texto + valPreenche;
			}
			return texto;
		}
	}
}