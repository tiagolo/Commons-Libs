package com.tiagolo.utils
{
	public class TopLevels
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
		
		public static function currencyFormater(num:Number,decimalPlace:Number=2,currency:String="R$"):String
        {
            //assigns true boolean value to neg in number less than 0
            var neg:Boolean = (num < 0);
           
            //make the number positive for easy conversion
            num = Math.abs(num)

            var roundedAmount:String = String(num.toFixed(decimalPlace));
           
            //split string into array for dollars and cents
            var amountArray:Array = roundedAmount.split(".");
            var dollars:String = amountArray[0]
            var cents:String = amountArray[1]
           
            //create dollar amount
            var dollarFinal:String = ""
            var i:int = 0
            for (i; i < dollars.length; i++)
            {
                if (i > 0 && (i % 3 == 0 ))
                {
                    dollarFinal = "." + dollarFinal;
                }
               
                dollarFinal = dollars.substr( -i -1, 1) + dollarFinal;
            }  
           
            //create Cents amount and zeros if necessary
            var centsFinal:String = String(cents);
           
            var missingZeros:int = decimalPlace - centsFinal.length;
       
            if (centsFinal.length < decimalPlace)
            {
                for (var j:int = 0; j < missingZeros; j++)
                {
                    centsFinal += "0";
                }
            }
           
            var finalString:String = ""
			currency += " ";
            if (neg)
            {
                finalString = "-"+currency + dollarFinal
            } else
            {
                finalString = currency + dollarFinal
            }

            if(decimalPlace > 0)
            {
                finalString += "," + centsFinal;
            }
           
            return finalString;
        }
	}
}