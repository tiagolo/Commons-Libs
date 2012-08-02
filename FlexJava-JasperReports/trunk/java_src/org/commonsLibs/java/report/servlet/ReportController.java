package org.commonsLibs.java.report.servlet;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRQuery;
import net.sf.jasperreports.engine.JRQueryChunk;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.repo.RepositoryUtil;

import org.commonsLibs.java.report.model.ReportExportType;
import org.commonsLibs.java.report.service.ReportService;
import org.commonsLibs.java.services.generic.GenericService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

/**
 * 
 * @author root
 * @version
 */

@Controller
public class ReportController {

	@Autowired
    private SessionFactory sessionFactory;

	@Autowired
	private ApplicationContext applicationContext;

    @SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	@RequestMapping({"/relatorios","/relatorios/*"})
    protected void exportJasperReport(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

    	
    	Session session = sessionFactory.openSession();
    	Connection conn = session.connection();
    	Map<String, Object> params = new HashMap<String,Object>();
        String report = request.getParameter("report");
        String aplicacao = request.getParameter("aplicacao");
        String userId = request.getParameter("userId");
        String exportType = request.getParameter("exportType");
        String destination = request.getParameter("destination");
        String method = request.getParameter("method");
        JasperReport jasperReport = null;
        JasperPrint jasperPrint = null;
        File reportFile = null;
        byte[] bytes = null;
        
        if(exportType == null)
        {
            exportType = ReportExportType.PDF.getExtension();
        }
        
        /* Verificação do caminho correto para o relatório.
         * Caso não seja informado o caminho absoluto do relatório na String report
         * o mesmo será atribuido apartir do caminho do contexto.
         */
        if(report != null && !report.contains(System.getProperty("catalina.home")))
        {
            //reportFile = reportManager.getReport(report);
        }
        else
        {
            reportFile = new File(report+".jasper");
        }
        
        
        try
        {
            jasperReport = RepositoryUtil.getReport(reportFile.getAbsolutePath());
                        
            for (JRParameter jrParameter : jasperReport.getParameters())
            {
                if(!jrParameter.isSystemDefined())
                {
                    int indexOfLeftBraquet = jrParameter.getName().indexOf("[");
                    int indexOfRightBraquet = jrParameter.getName().indexOf("]");
                    if(indexOfLeftBraquet >= 0 && indexOfLeftBraquet < indexOfRightBraquet)
                    {
                        params.put(jrParameter.getName(), request.getParameter(jrParameter.getName()));
                    }
                    else
                    {
                        params.put(jrParameter.getName(), getParameterValue(request.getParameter(jrParameter.getName()), jrParameter.getValueClass()));
                    }
                }
            }
            
        }
        catch (Exception jre)
        {
            for (Iterator iterator = request.getParameterMap().entrySet().iterator(); iterator.hasNext();)
            {
                Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) iterator.next();
                params.put(entry.getKey(),entry.getValue()[0]);
            }
        }

        

        try {
        	
        	
        	if(destination != null && method != null)
        	{
        		GenericService bean = (GenericService) applicationContext.getBean(destination);
        		Method methodImpl = bean.getClass().getMethod(method, new Class<?>[]{Map.class});
        		
        		jasperPrint = JasperFillManager.fillReport(reportFile.getAbsolutePath(), params, (JRDataSource)methodImpl.invoke(bean, params));
        	}
        	else
        	{
        	    
        		jasperPrint = JasperFillManager.fillReport(reportFile.getAbsolutePath(),params,conn);
        	}
        	
        	if(jasperPrint.getPages() != null && jasperPrint.getPages().size() != 0)
        	{
        	    new ReportService().executarReport(aplicacao,reportFile,Long.parseLong(userId));
        	    
        	    ReportExportType reportExportType = ReportExportType.getTypeFromValue(exportType);
        	    
	            bytes = reportExportType.exportReport(jasperPrint);
	            
	            if (bytes != null && bytes.length > 0) {
	                response.setContentType(reportExportType.getMimeType());
	                response.setContentLength(bytes.length);
	                ServletOutputStream ouputStream = response
	                .getOutputStream();
	                ouputStream.write(bytes, 0, bytes.length);
	                ouputStream.flush();
	                ouputStream.close();
	            }
        	}
        	else
        	{
        		throw new ServletException("<h1>Não foram encontrados registros no relatório</h1>");
        	}
        } catch (Exception e) {
            
            if(report != null)
            {
                e.printStackTrace();
            }
            
            String detail = "";
            detail = getQueryFromJasperReport(params, jasperReport);
            detail += getParametersFromJasperReport(params, jasperReport);
            
            if(e.getCause() instanceof SQLException)
            {
                detail += "<li>" + e.getCause().getClass().getCanonicalName() + " <b>" + removeTagsFromString(e.getCause().getMessage()) + "</b></li>\n";
            }
            
            detail += "<li>" + removeTagsFromString(e.toString()) + "</li>\n";
            for (StackTraceElement element : e.getStackTrace())
            {
                detail += "<li>" + removeTagsFromString(element.toString()) + "</li>\n";
            }
            
            request.setAttribute("msg",e.getMessage());
            request.setAttribute("detail",detail);
        	RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
        	dispatcher.forward(request, response);
		}
        finally
        {
        	try {
        		if(conn != null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
        	session.close();
        }
    }

    private String getQueryFromJasperReport(Map<String,Object> params, JasperReport jasperReport)
    {
		String detail;

		try
		{
		    JRQuery query = jasperReport.getQuery();
        
            detail = "<li>Consulta executada: <pre>";
            
            for (JRQueryChunk queryChunk : query.getChunks())
            {
                switch(queryChunk.getType())
                {
                    case JRQueryChunk.TYPE_PARAMETER:
                        detail += "<i><b>" + removeTagsFromString("'"+params.get(queryChunk.getText()).toString()+"'") + "</b></i>";
                        break;
                    case JRQueryChunk.TYPE_PARAMETER_CLAUSE:
                        detail += "<i><b>" + removeTagsFromString(params.get(queryChunk.getText()).toString()) + "</b></i>";
                        break;
                    default:
                        detail += removeTagsFromString(queryChunk.getText());       
                }
            }
            
            detail += "</pre></li>\n";
        
		}catch(Exception e)
		{
		    detail = "<li>Não foi possível recurepar Consulta executada pelo relatório</li>";
		}
        return detail;
    }
    
    private String getParametersFromJasperReport(Map<String,Object> params, JasperReport jasperReport)
    {
        String detail = "<li>Parametros enviados: <table>";
        
        for (JRParameter parameter : jasperReport.getParameters())
        {
            if(!parameter.isSystemDefined() && params.containsKey(parameter.getName()))
            {
                detail += "<tr><td>"+parameter.getName() + "</td><td><b>" + params.get(parameter.getName()) + "</b></td></tr>\n";
            }
        }
        detail += "</table></li>\n";
        return detail;
    }
    
    private String removeTagsFromString(String value)
    {
        return value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

    private Object getParameterValue(String value, Class<?> type) throws ParseException, UnsupportedEncodingException
    {
        if((value == null || value == "") && type != String.class)
        {
            return null;
        }
        else if(type == Boolean.class)
        {
            return new Boolean(value);
        }
        else if(type == Date.class)
        {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            return dateFormat.parse(value);
        }
        else if(type == Long.class)
        {
            return Long.parseLong(value);
        }
        else if(type == Integer.class)
        {
            return Integer.parseInt(value);
        }
        else if(type == Float.class)
        {
            return Float.parseFloat(value);
        }
        else if(type == Double.class)
        {
            return Double.parseDouble(value);
        }
        else if(type == String.class)
        {
            return new String(value.getBytes("ISO-8859-1"),"UTF-8");
        }
        else
        {
            return new Gson().fromJson(new String(value.getBytes("ISO-8859-1"),"UTF-8"), type);
        }
    }
}