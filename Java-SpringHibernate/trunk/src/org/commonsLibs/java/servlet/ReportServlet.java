package org.commonsLibs.java.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

import org.commonsLibs.java.services.generic.GenericService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 
 * @author root
 * @version
 */

@SuppressWarnings({"serial", "unchecked", "deprecation", "rawtypes"})
public class ReportServlet extends HttpServlet {

	private ServletContext sc;
	
	private SessionFactory sessionFactory;

	private AutowireCapableBeanFactory beanFactory;
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		sc = config.getServletContext();
		
		WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(sc);
		
		beanFactory = webApplicationContext.getAutowireCapableBeanFactory();
		
		sessionFactory = beanFactory.getBean(SessionFactory.class);
	}

    protected void service(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

    	byte[] bytes = null;
    	Map params = new HashMap<String,String>();
        String report = request.getParameter("report");
        String destination = request.getParameter("destination");
        String method = request.getParameter("method"); 
        File reportFile = new File(sc.getRealPath("WEB-INF/relatorios/"+report+".jasper"));
         

        for (Iterator iterator = request.getParameterMap().entrySet().iterator(); iterator.hasNext();)
        {
            Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) iterator.next();
	        params.put(entry.getKey(),entry.getValue()[0]);
        }
        
        Session session = sessionFactory.openSession();
        Connection conn = session.connection();

        try {
        	
        	JasperPrint jasperPrint = null;
        	
        	if(destination != null && method != null)
        	{
        		GenericService bean = (GenericService) beanFactory.getBean(destination);
        		Method methodImpl = bean.getClass().getMethod(method, new Class<?>[]{Map.class});
        		jasperPrint = JasperFillManager.fillReport(reportFile.getPath(), params, (JRDataSource)methodImpl.invoke(bean, params));
        	}
        	else
        	{
        		jasperPrint = JasperFillManager.fillReport(reportFile.getPath(),params,conn);
        	}
        	
        	if(jasperPrint.getPages() != null && jasperPrint.getPages().size() != 0)
        	{
	            bytes = JasperExportManager.exportReportToPdf(jasperPrint);
	            if (bytes != null && bytes.length > 0) {
	                response.setContentType("application/pdf");
	                response.setHeader("Content-Disposition", "inline; filename="+report+".pdf"); 
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
        		response.setContentType("text/html"); 
        		PrintWriter printWriter = response.getWriter();
        		printWriter.print("<h1>Não foram encontrados registros no relatório</h1>");
        		printWriter.flush();
        		printWriter.close();
        	}
        } catch (Exception e) {
        	response.setContentType("text/html"); 
        	PrintWriter printWriter = response.getWriter();
    		printWriter.print(e.getMessage());
    		printWriter.flush();
    		printWriter.close();
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

}