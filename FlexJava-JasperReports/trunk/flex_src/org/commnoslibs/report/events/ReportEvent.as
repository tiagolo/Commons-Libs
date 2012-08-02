package org.commnoslibs.report.events
{
	import flash.events.Event;

	import mx.collections.ArrayCollection;
	import mx.containers.Form;

	import org.commnoslibs.report.models.Report;

	public class ReportEvent extends Event
	{

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Static Property 
		//--------------------------------------

		public static const CLEAR_FORM:String = "ReportEvent.CLEAR_FORM";

		public static const DOWNLOAD:String = "ReportEvent.DOWNLOAD";

		public static const FILL_PARAMETERS:String = "ReportEvent.FILL_PARAMETERS";

		public static const FIND_REPORTS:String = "ReportEvent.FIND_REPORTS";

		public static const LOGIN_COMPLETE:String = "ReportEvent.LOGIN_COMPLETE";

		public static const PRINT:String = "ReportEvent.PRINT";

		public static const REMOVE:String = "ReportEvent.REMOVE";

		public static const UPLOAD:String = "ReportEvent.UPLOAD";

		public static const URLREQUEST:String = "ReportEvent.URLREQUEST";

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function ReportEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		//--------------------------------------
		//   Property 
		//--------------------------------------

		public var exportType:String;

		public var form:Form;

		public var parameters:ArrayCollection;

		public var perfilId:int;

		public var report:Report;

		public var userId:int;
	}
}


