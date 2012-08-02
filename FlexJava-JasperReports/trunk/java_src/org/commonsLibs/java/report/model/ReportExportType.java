package org.commonsLibs.java.report.model;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

import org.commonsLibs.java.report.manager.ReportExportManager;

public enum ReportExportType
{
    PRINT("print", "application/pdf", ReportExportManager.class, "exportReportPrint"), 
    PDF("pdf", "application/pdf", ReportExportManager.class, "exportReportToPdf"), 
    XLS("xls", "application/vnd.ms-excel", ReportExportManager.class, "exportReportToXls"),
    CSV("csv", "text/csv", ReportExportManager.class, "exportReportToCSV"),
    HTML("html", "text/html", ReportExportManager.class, "exportReportToHTML");

    private String extension;
    private String mimeType;
    private Class<?> methodClass;
    private String methodName;

    private ReportExportType(String extension, String mimeType, Class<?> methodClass, String methodName)
    {
        this.extension = extension;
        this.mimeType = mimeType;
        this.methodClass = methodClass;
        this.methodName = methodName;
    }

    public String getExtension()
    {
        return extension;
    }
    
    public String getMimeType()
    {
        return mimeType;
    }

    public byte[] exportReport(JasperPrint jasperPrint) throws JRException, IllegalArgumentException, IllegalAccessException, InvocationTargetException, SecurityException, NoSuchMethodException, InstantiationException
    {
        Method method = methodClass.getMethod(methodName, JasperPrint.class);
        return (byte[]) method.invoke(methodClass.newInstance(),jasperPrint);
    }

    public static ReportExportType getTypeFromValue(String type)
    {
        for (ReportExportType reportExportType : ReportExportType.class.getEnumConstants())
        {
            if (reportExportType.extension.equalsIgnoreCase(type)) { return reportExportType; }
        }

        throw new TypeNotPresentException("Tipo de exportação de relatório '" + type + "' não definida", new Throwable());
    }
}
