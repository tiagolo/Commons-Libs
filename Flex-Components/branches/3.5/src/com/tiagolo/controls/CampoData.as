package com.tiagolo.controls
{
	import mx.controls.DateField;
	import mx.events.FlexEvent;
	import mx.formatters.DateBase;
	
	public class CampoData extends DateField{
		// Dias nomes
		private const diasNomes:Array = ["D","S","T","Q","Q","S","S"];
		// Meses
		private const mesesNomes:Array = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"];
		
		/* Contrutor */
		public function CampoData() {
			super();
			
			this.width=95;
			dayNames=diasNomes;
			monthNames=mesesNomes;
			formatString="DD/MM/YYYY";
			restrict="0-9";
			editable=true;
			addEventListener(FlexEvent.VALUE_COMMIT,completar);
		}
		
		/**
		* Função para completar
		*/
		private function completar(event:FlexEvent):void {
			var str:String = event.target.text as String;
			if ( str.charAt(2) != "/" || str.charAt(5) != "/" ) {
				var mask:String;
				var dataAtual:Date = new Date();
			
				if ( str.length == 2 ) {
					mask = str.substr(0, 2) + "/" + (dataAtual.getMonth()+1).toString() + "/" + dataAtual.getFullYear();
					event.target.text = mask;
				} else if ( str.length == 4 ) {
					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + dataAtual.getFullYear().toString();
					event.target.text = mask;
				} else if ( str.length == 6 ) {
					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + str.substr(4, 4);
					event.target.text = mask;
				} else if ( str.length == 8 ) {
					mask = str.substr(0, 2) + "/" + str.substr(2,2) + "/" + str.substr(4, 4);
					event.target.text = mask;
				}
		
			}
			
			if ( this.editable == true ) {
			// Validar.dataField(event);
			}
		}
		
		/**
		* Tipo para validação
		*/
		[Inspectable(category="WebInovacoes")]
		public function set valor (dataInformada:Date):void{
			if (dataInformada!=null){
				data=dataInformada;
				selectedDate=dataInformada;
				//text=dataInformada.getDate().toString()+ "/"+ (dataInformada.getMonth()+1).toString() + "/"+ dataInformada.getFullYear().toString();
				
				var dia:String=dataInformada.getDate().toString();
				if (dia.length ==1) dia = "0"+dia;
					var mes:String= (dataInformada.getMonth()+01).toString() ;
				if (mes.length ==1) mes = "0"+mes;
					text=dia + "/"+ mes + "/"+ dataInformada.getFullYear().toString();
				
			}
		}
	
	}
}