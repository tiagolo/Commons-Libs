package br.pro.tiagolopes.business
{
	import br.pro.tiagolopes.model.Param;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	public class ReportManager
	{
		public function print(report:String,params:Array):void
		{
			var variables:URLVariables = new URLVariables();
			variables.report = report;
			variables.time = new Date().getTime();
			
			for each (var param:Param in params)
			{
				variables[param.key] = param.value;
			}
			
			var request:URLRequest = new URLRequest("relatorios/"+report);
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			navigateToURL(request,"_blank");
		}
		
		public function get firstOfWeek():Date
		{
			var date:Date = new Date();
			date.date -= date.day;
			return date;
		}

		public function get lastOfWeek():Date
		{
			var date:Date = new Date();
			date.date -= date.day;
			date.date += 6;
			return date;
		}
	}
}