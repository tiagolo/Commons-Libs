package org.commonsLibs.java.report.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.repo.RepositoryUtil;

import org.apache.commons.lang3.StringUtils;
import org.commonsLibs.java.report.dao.ReportDao;
import org.commonsLibs.java.report.model.JRDesignParameter;
import org.commonsLibs.java.report.model.Report;
import org.commonsLibs.java.report.model.ReportFolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

@Service("reportService")
@RemotingDestination
public class ReportService 
{
	@Autowired
	private ReportDao dao;
	
	@PostConstruct
	protected void startReportCollection() throws Exception
	{
		Report report = new Report("relatorio","Relatório","/commonsLibs/relatorios/relatorio");
		report.setAplicacao("CommonsLibs");
		
		File file = new File("/Users/tiagolo/Desktop/report1.jasper");
		FileInputStream fileInputStream = new FileInputStream(file);
		report.setJasperFile(new byte[(int)file.length()]);
		fileInputStream.read(report.getJasperFile());
		fileInputStream.close();
		
		dao.save(report);
		
		Collection<ReportFolder> findReports;
			findReports = findReports();
			System.out.println(findReports.toString());
			
			for(ReportFolder reportFolder : findReports)
			{
				for (ReportFolder report_ : reportFolder.getChildren()) {
					if(report_ instanceof Report)
					{
						 List<JRDesignParameter> parametros = findParametros((Report) report_);
						 System.out.println(parametros.toString());
					}
				}
			}
	}
	
	
	@RemotingInclude
	public Collection<ReportFolder> findReports() throws Exception
	{
		return findReports(null);
	}
	
	@RemotingInclude
    public Collection<ReportFolder> findReports(String aplicacao) throws Exception
    {
		Report reportFilter = new Report();
		reportFilter.setAplicacao(aplicacao);
		
        List<Report> reports = dao.find(reportFilter);
        Map<String, ReportFolder> folders = new HashMap<String, ReportFolder>();
        
        for(Report report : reports)
        {
        	ReportFolder reportFolder = null;
        	String reportAplicacao = report.getAplicacao();
        	
			if(!folders.containsKey(reportAplicacao))
        	{
				reportFolder = new ReportFolder(reportAplicacao, new ArrayList<ReportFolder>());
        		folders.put(reportAplicacao, reportFolder);
        	}
        	else
        	{
        		reportFolder = folders.get(reportAplicacao);
        	}
        	
        	reportFolder.getChildren().add(report);
        }
        
        return folders.values();
    }

    protected List<ReportFolder> getReportFolderList(File file) throws JRException
    {
        List<ReportFolder> reports = new ArrayList<ReportFolder>();

        for (File rpt : file.listFiles(new Filtro()))
        {

            ReportFolder report = null;

            if (rpt.isDirectory())
            {
                report = new ReportFolder(rpt.getName().split(".jasper")[0], getReportFolderList(rpt));
            }
            else
            {
                try
                {
                    report = getReportFromFile(rpt);
                    ((Report) report).setAplicacao(file.getName());
                }
                catch (JRException e)
                {
                    e.printStackTrace();
                }
                catch (JRRuntimeException e) {
                    e.printStackTrace();
                }
            }
            if (report != null)
            {
                reports.add(report);
            }
        }
        return reports;
    }

    public List<JRDesignParameter> findParametros(Report report) throws JRException, IOException
    {
    	ByteArrayInputStream inputStream = new ByteArrayInputStream(report.getJasperFile());
		JasperReport jasperReport = (JasperReport) JRLoader.loadObject(inputStream);
        //JasperReport jasperReport = (JasperReport) RepositoryUtil.getReport(report.getPath() + ".jasper");
		inputStream.close();

        List<JRParameter> parametersList = new ArrayList<JRParameter>(Arrays.asList(jasperReport.getParameters()));
        List<JRDesignParameter> jrDesignParameters = new ArrayList<JRDesignParameter>();

        for (int i = parametersList.size() - 1; i >= 0; i--)
        {
            JRParameter parameter = parametersList.get(i);
            if (!parameter.isSystemDefined())
            {
                JRDesignParameter designParameter = new JRDesignParameter();

                designParameter.setDefaultValueExpression(parameter.getDefaultValueExpression());
                designParameter.setDescription(parameter.getDescription());
                designParameter.setForPrompting(parameter.isForPrompting());
                designParameter.setName(parameter.getName());
                designParameter.setNestedType(parameter.getNestedType());
                designParameter.setNestedTypeName(parameter.getNestedTypeName());
                designParameter.setSystemDefined(parameter.isSystemDefined());
                designParameter.setValueClass(parameter.getValueClass());
                designParameter.setValueClassName(parameter.getValueClassName());
                
                for (String propertiyKey : parameter.getPropertiesMap().getPropertyNames())
                {
                    String property = parameter.getPropertiesMap().getProperty(propertiyKey);
                    designParameter.getPropertiesMap().setProperty(propertiyKey, property);
                }                

                jrDesignParameters.add(designParameter);
            }
        }

        return jrDesignParameters;
    }
    
    public void removeReport(Report report) throws Exception
    {
//        MenuModuloManager menuModuloManager = SpringBeans.getManager(MenuModuloManager.class);
//        menuModuloManager.remover(report);
    }

    public void salvarReport(String aplicacao, File file, Long userId) throws Exception
    {
//        MenuModuloManager menuModuloManager = SpringBeans.getManager(MenuModuloManager.class);
//        menuModuloManager.salvar(aplicacao, getReportFromFile(file), userId);
    }

    public void executarReport(String aplicacao, File file, Long userId) throws Exception
    {
//        MenuModuloManager menuModuloManager = SpringBeans.getManager(MenuModuloManager.class);
//
//        Report report = getReportFromFile(file);
//
//        Menu menu = menuModuloManager.getMenuFromJasper(aplicacao, report);
//
//        if (menu != null && menu.getId() == null)
//        {
//            menu = null;
//        }
//
//        User user = new User();
//        user.setId(userId);
//
//        ReportAuditManager reportAuditManager = SpringBeans.getManager(ReportAuditManager.class);
//        reportAuditManager.executar(report, menu, user);
    }

    private Report getReportFromFile(File file) throws JRException
    {
        JasperReport jasperReport = (JasperReport) RepositoryUtil.getReport(file.getAbsolutePath());
        return new Report(file.getName().split(".jasper")[0], jasperReport.getName(), file.getAbsolutePath().split(".jasper")[0]);
    }

    private class Filtro implements FilenameFilter
    {
        public boolean accept(File dir, String name)
        {
            return (name.endsWith(".jasper") && !(StringUtils.contains(name, "_sub") || StringUtils.contains(name, "sub_"))) || new File(dir, name).isDirectory();
        }
    }
}
