package org.commnoslibs.report.models
{
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="br.com.mv.report.model.Report")]
	public class Report extends ReportFolder
	{
		
		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		//   Property 
		//--------------------------------------
		
		public var aplicacao:String;
		
		public var data:String;
		
		public var name:String;
		
		public var parameters:ArrayCollection;
	}
}