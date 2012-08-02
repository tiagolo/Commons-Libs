package org.commnoslibs.report.controllers
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.rpc.AbstractService;
	import mx.rpc.Fault;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	import org.commnoslibs.report.events.ReportEvent;
	import org.commnoslibs.report.models.JRDesignParameter;
	import org.commnoslibs.report.models.Report;
	import org.commnoslibs.report.models.ReportExportType;
	import org.commnoslibs.report.models.ReportFolder;
	import org.commnoslibs.report.models.types.JRParameterType;
	import org.commnoslibs.report.models.types.JRTagCombo;
	import org.commnoslibs.report.models.types.JRTagDate;
	import org.commnoslibs.report.models.types.JRTagDateTime;
	import org.commnoslibs.report.models.types.JRTagPeriodo;
	import org.commnoslibs.report.models.types.JRTagPeriodoDateTime;
	import org.commnoslibs.report.models.types.JRTagTime;
	import org.commnoslibs.report.models.types.JRTypeBoolean;
	import org.commnoslibs.report.models.types.JRTypeDate;
	import org.commnoslibs.report.models.types.JRTypeDouble;
	import org.commnoslibs.report.models.types.JRTypeFloat;
	import org.commnoslibs.report.models.types.JRTypeInteger;
	import org.commnoslibs.report.models.types.JRTypeLong;
	import org.commnoslibs.report.models.types.JRTypeString;
	import org.commonsLibs.swiz.events.AlertEvent;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.utils.services.ServiceHelper;

	public class ReportController extends AbstractController
	{

		//------------------------------------------------------------------------------
		//
		//   Metodos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function ReportController()
		{
			types = [];
		}

		//------------------------------------------------------------------------------
		//
		//   Attributos 
		//
		//------------------------------------------------------------------------------

		//--------------------------------------
		//   Property 
		//--------------------------------------

		[Bindable]
		public var contextRoot:String;

		[Bindable]
		public var dataProvider:ArrayCollection;

		[Bindable]
		public var service:AbstractService;

		[Inject]
		public var serviceHelper:ServiceHelper;

		[Bindable]
		public var userId:int;

		private var _report:Report;

		private var _types:Array;

		//--------------------------------------
		//   Function 
		//--------------------------------------

		[EventHandler(event = "ReportEvent.DOWNLOAD")]
		public function download():void
		{
			var request:URLRequest = new URLRequest(contextRoot + "/download/" + report.name + ".jrxml");

			request.data = new URLVariables();
			request.data["filePath"] = report.data + ".jrxml";
			request.method = URLRequestMethod.POST;

			navigateToURL(request);
		}

		[EventHandler(event = "ReportEvent.FILL_PARAMETERS", properties = "form,report")]
		public function fillParameters(form:Form, report:Report):void
		{
			this.report = ObjectUtil.copy(report) as Report;
			serviceHelper.executeServiceCall(service.findParametros(report), fillParameters_resultHandler, null, [form]);
		}

		[EventHandler(event = "ReportEvent.FIND_REPORTS")]
		public function findReports():void
		{
			serviceHelper.executeServiceCall(service.findReports(), findResults_resultHandler);
		}

		[EventHandler(event = "ReportEvent.PRINT", properties = "exportType")]
		public function imprimir(exportType:String = ReportExportType.PDF):void
		{
			try
			{
				var variables:URLVariables = getParametersValues(report.parameters);
				variables.report = report.data;
				variables.exportType = exportType;
				variables.time = new Date().time;
				variables.userId = userId;
				variables.aplicacao = report.aplicacao;

				var request:URLRequest = new URLRequest(contextRoot + "/relatorios/" + report.name + "." + exportType);
				request.data = variables;
				request.method = URLRequestMethod.POST;

				navigateToURL(request, "_blank");
			}
			catch (e:Fault)
			{
				dispatcher.dispatchEvent(new AlertEvent(AlertEvent.ERROR, e.faultCode + " - " + e.faultString, "Mensagem"));
			}
		}

		[EventHandler(event = "ReportEvent.LOGIN_COMPLETE", properties = "userId")]
		public function loginComplete(userId:int):void
		{
			this.userId = userId;
		}

		[EventHandler(event = "ReportEvent.REMOVE", properties = "report")]
		public function remove(report:Report):void
		{
			dispatcher.dispatchEvent(new AlertEvent(AlertEvent.CONFIRM, "Deseja realmente remover o relatório selecionado:\n" + report.label + "\n\n", "Remoção de relatório", function(event:CloseEvent):void
			{
				if (event.detail == Alert.YES)
				{
					report = ObjectUtil.copy(report) as Report
					report.parameters = null;
					serviceHelper.executeServiceCall(service.removeReport(report), remove_resultHandler);
				}
			}));
		}

		[Bindable]
		public function get report():Report
		{
			return _report;
		}

		public function set report(value:Report):void
		{
			_report = value;
		}

		[URLMapping("/report/{0}")]
		public function setReportURL(name:String):void
		{
			if (!dataProvider)
			{
				setTimeout(setReportURL, 1000, name);
			}
			else
			{
				var report:Report = getReportFromReportFolder(name, dataProvider);

				if (report)
				{
					this.report = report as Report;
					var reportEvent:ReportEvent = new ReportEvent(ReportEvent.URLREQUEST);
					reportEvent.report = report;

					dispatcher.dispatchEvent(reportEvent);
				}
			}
		}

		[ArrayElementType("br.com.mv.report.model.type.JRParameterType")]
		[Bindable]
		public function get types():Array
		{
			return _types;
		}

		public function set types(value:Array):void
		{
			var basicTypes:Array = [new JRTypeString(), new JRTypeBoolean(), new JRTypeDate(), new JRTagPeriodo(), new JRTypeDouble(), new JRTypeFloat(), new JRTypeInteger(), new JRTypeLong(), new JRTagDate(), new JRTagTime(), new JRTagDateTime(), new JRTagCombo(), new JRTagPeriodoDateTime()];

			_types = basicTypes;

			if (value)
			{
				_types = _types.concat(value);
			}
		}

		private function addParameterField(parameter:JRDesignParameter):UIComponent
		{
			for each (var jrType:JRParameterType in types)
			{
				if (parameter.isTag())
				{
					if (parameter.name.toLowerCase().indexOf(jrType.type.toLowerCase()) >= 0)
					{
						parameter.type = jrType;
						break;
					}
				}
				else if (jrType.type == parameter.valueClassName)
				{
					parameter.type = jrType;
					break;
				}
			}

			if (!parameter.type)
			{
				parameter.type = new JRTypeString();
			}

			var field:UIComponent = parameter.type.addParameterField(parameter);
			parameter.field = field;

			return field;
		}

		private function fillParameters_resultHandler(event:ResultEvent, form:Form):void
		{
			report.parameters = event.result as ArrayCollection;
			;

			form.removeAllChildren();

			for each (var parameter:JRDesignParameter in report.parameters)
			{
				if (!parameter.isInvisible())
				{
					var formItem:FormItem = new FormItem();
					formItem.name = parameter.name;
					formItem.label = parameter.description ? parameter.description : parameter.name;
					formItem.data = parameter;

					var field:UIComponent = addParameterField(parameter);
					formItem.addChild(field);
					form.addChild(formItem);
				}
			}

			form.invalidateDisplayList();
		}

		private function findResults_resultHandler(event:ResultEvent):void
		{
			var sort:Sort = new Sort();
			sort.fields = [new SortField("label")];

			dataProvider = event.result as ArrayCollection;
			dataProvider.sort = sort;
			dataProvider.refresh();
		}

		private function getParametersValues(parameters:ArrayCollection):URLVariables
		{
			var variables:URLVariables = new URLVariables();
			var errorString:String = "";

			for each (var parameter:JRDesignParameter in parameters)
			{
				if (!parameter.isInvisible())
				{
					parameter.field.errorString = null;

					var parameterValue:Object = parameter.type.getParameterValue(parameter);

					if (parameter.isRequired() && !parameterValue)
					{
						parameter.field.errorString = "Campo obrigatório";
					}
					else
					{
						variables[parameter.name] = parameterValue;
					}

					if (parameter.field.errorString)
					{
						errorString += "\n" + (parameter.description ? parameter.description : parameter.name) + " - " + parameter.field.errorString
					}
				}
			}

			if (errorString)
			{
				throw new Fault("Preencha os campos obrigatórios:", errorString)
			}

			return variables;
		}

		private function getReportFromReportFolder(name:String, reportFolderChildren:ArrayCollection):Report
		{
			var seachString:Array = name.split("/");

			for each (var file:ReportFolder in reportFolderChildren)
			{
				if (file is Report && Report(file).name == seachString[0])
				{
					return file as Report;
				}
				else if (file is ReportFolder && file.label == seachString[0] && file.children)
				{
					var report:Report = getReportFromReportFolder(seachString[1], file.children);

					if (report)
					{
						return report;
					}
				}
			}

			return null;
		}

		private function remove_resultHandler(event:ResultEvent):void
		{
			report = null;
			findReports();

			dispatcher.dispatchEvent(new ReportEvent(ReportEvent.CLEAR_FORM));
		}
	}
}

