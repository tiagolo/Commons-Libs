package org.commnoslibs.report.models.types
{
	
	import com.yahoo.astra.mx.controls.TimeStepper;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.DateField;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	
	import org.commnoslibs.report.models.JRDesignParameter;
	
	public class JRTagPeriodoDateTime implements JRParameterType
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public function get type():String
		{
			return "[periodoDateTime]";
		}
		
		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		public function JRTagPeriodoDateTime()
		{
		}
		
		//--------------------------------------
		//   Function 
		//--------------------------------------
		
		public function addParameterField(value:JRDesignParameter):UIComponent
		{
			var parametros:ArrayCollection = value.designProperties;
			var hbox:HBox = new HBox();
			var vboxLabel:VBox = new VBox();
			
			var vboxDataInicio:VBox = new VBox();
			var labelDate:Label = new Label();
			
			var vboxDataFinal:VBox = new VBox();
			var labelTime:Label = new Label();
			
			var fieldDate1:DateField = new DateField();
			var fieldDate2:DateField = new DateField();
			
			var fieldTime1:TimeStepper = new TimeStepper();
			var fieldTime2:TimeStepper = new TimeStepper();

			vboxDataInicio.name = "vboxDataInicio";
			vboxDataFinal.name = "vboxDataFinal";
			
			fieldDate1.name = "dataInicial";
			fieldDate1.formatString = "DD/MM/YYYY";
			
			fieldDate2.name = "dataFinal";
			fieldDate2.formatString = "DD/MM/YYYY";

			labelDate.text = "à";
			
			
			fieldTime1.name = "horaInicial";
			fieldTime2.name = "horaFinal";
			labelTime.text = "às";
			fieldTime1.setStyle("showSeconds",false);
			fieldTime1.setStyle("showAMPM",false);
			fieldTime1.setStyle("useTwelveHourFormat",false);
			fieldTime2.setStyle("showSeconds",false);
			fieldTime2.setStyle("showAMPM",false);
			fieldTime2.setStyle("useTwelveHourFormat",false);
			
			var hrInicial:Date = new Date();
			hrInicial.hours = 0;
			hrInicial.minutes = 0;
			fieldTime1.value = hrInicial;
			var hrFinal:Date = new Date();
			hrFinal.hours = 23;
			hrFinal.minutes = 59;
			fieldTime2.value = hrFinal;
			
			
			
			vboxDataInicio.addChild(fieldDate1);
			vboxDataInicio.addChild(fieldTime1);
			vboxDataFinal.addChild(fieldDate2);
			fieldDate2.visible = false;
			labelDate.visible = false;
			
			if(parametros.length > 0){
				
				for(var i:int; i < parametros.length; i++){
					if(parametros[i].label == 'limiteData' && parametros[i].data != '1'){
						fieldDate2.visible = true;
						labelDate.visible = true;
					}
				}
							
			}else{
				fieldDate2.visible = true;
				labelDate.visible = true;
			}
			
			
			vboxDataFinal.addChild(fieldTime2);
			vboxLabel.addChild(labelDate);
			vboxLabel.addChild(labelTime);
			
			hbox.addChild(vboxDataInicio);
			hbox.addChild(vboxLabel);
			hbox.addChild(vboxDataFinal);
			
			hbox.name = value.name;
			hbox.data = value;
			value.field = hbox;
			
			return hbox;
		}
		
		public function getParameterValue(value:JRDesignParameter):Object
		{
			var dtFormater:DateFormatter = new DateFormatter();
			var hrFormater:DateFormatter = new DateFormatter();
			dtFormater.formatString = "DD/MM/YYYY";
			hrFormater.formatString = "JJ:NN";
			
			var hbox:HBox = HBox(value.field);
			var vboxDataInicio:VBox = VBox(hbox.getChildByName("vboxDataInicio"));
			var vboxDataFinal:VBox = VBox(hbox.getChildByName("vboxDataFinal"));
			
			var limiteData:String;
			var dataFinal:DateField = null;
				
			var dataInicial:DateField = DateField(vboxDataInicio.getChildByName("dataInicial"));			
			var horaInicial:TimeStepper = TimeStepper(vboxDataInicio.getChildByName("horaInicial"));	
			var horaFinal:TimeStepper = TimeStepper(vboxDataFinal.getChildByName("horaFinal"));	
			
			
			if(value.designProperties.length > 0){
				
				for(var i:int; i < value.designProperties.length; i++){
					if(value.designProperties[i].label == 'limiteData' && value.designProperties[i].data != '1'){
						limiteData = value.designProperties[i].data;
						dataFinal = DateField(vboxDataFinal.getChildByName("dataFinal"));
					}
				}
				
			}else{
				limiteData = null;
				dataFinal = DateField(vboxDataInicio.getChildByName("dataFinal"));
			}
			
				
			var dtInicial:String = "TO_DATE('" + dtFormater.format(dataInicial.selectedDate) + " " + hrFormater.format(horaInicial.value) +"', 'DD/MM/YYYY HH24:MI')";
			var dtFinal:String = "";
			if(dataFinal){
				dtFinal = "TO_DATE('" + dtFormater.format(dataFinal.selectedDate) + " "+ hrFormater.format(horaFinal.value) +"', 'DD/MM/YYYY HH24:MI')";
			}else{
				dtFinal = "TO_DATE('" + dtFormater.format(dataInicial.selectedDate) + " "+ hrFormater.format(horaFinal.value) +"', 'DD/MM/YYYY HH24:MI')";
			}
			
			
			

			value.field.errorString = null;
			
			if(dataFinal && (!dataInicial.selectedDate || !dataFinal.selectedDate))
			{
				value.field.errorString = "Por favor selecione um período válido";
			}
			else if ( !dataInicial.selectedDate) 
			{
				value.field.errorString = "Por favor selecione um período válido";
			}
			else if(dataInicial.errorString)
			{
				value.field.errorString = dataInicial.errorString;
			}
			else if(dataFinal && dataFinal.errorString)
			{
				value.field.errorString = dataFinal.errorString;
			}
			else if(dataFinal && dataInicial.selectedDate > dataFinal.selectedDate)
			{
				value.field.errorString = "A data inicial não pode ser maior que a data final";
			}
			else if (dataFinal && limiteData && (dataFinal.selectedDate.time - dataInicial.selectedDate.time > (Number(limiteData)*24*60*60*1000)))
			{
				value.field.errorString = "Período não pode ser maior que "+limiteData+" dias.";
			}
			else if(!dataFinal && (horaInicial.value.hours > horaFinal.value.hours || (horaInicial.value.hours == horaFinal.value.hours && horaInicial.value.minutes > horaFinal.value.minutes)))
			{
				value.field.errorString = "Hora inicial não pode ser maior que a final";
			}
			
			return dtInicial + " AND " + dtFinal;
		}
	}
}