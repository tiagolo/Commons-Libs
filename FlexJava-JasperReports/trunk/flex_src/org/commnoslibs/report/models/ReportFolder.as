package org.commnoslibs.report.models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="br.com.mv.report.model.ReportFolder")]
	public class ReportFolder
	{
		public var label:String;
		
		[ArrayElementType("br.com.mv.report.model.ReportFolder")]
		public var children:ArrayCollection;
	}
}