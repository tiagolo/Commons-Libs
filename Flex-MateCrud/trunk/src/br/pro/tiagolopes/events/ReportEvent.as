package br.pro.tiagolopes.events
{
	import flash.events.Event;
	
	public class ReportEvent extends Event
	{
		public static const PRINT:String  = "REPORT_print";
		
		public var report:String;
		public var params:Array;
		
		public function ReportEvent(type:String, report:String, params:Array, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.report = report;
			this.params = params;
			
			super(type, bubbles, cancelable);
		}
	}
}