package org.commonsLibs.java.report.manager;

import java.io.ByteArrayOutputStream;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRCsvExporterParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;

public class ReportExportManager
{
    public byte[] exportReportPrint(JasperPrint jasperPrint) throws JRException
    {
        JasperPrintManager.printReport(jasperPrint, true);
        return null;
    }
    
    public byte[] exportReportToPdf(JasperPrint jasperPrint) throws JRException
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        JRPdfExporter exporter = new JRPdfExporter();
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
        
        exporter.exportReport();
        
        return baos.toByteArray();
    }

    public byte[] exportReportToXls(JasperPrint jasperPrint) throws JRException
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        JRXlsExporter exporter = new JRXlsExporter();
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
        exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,true);
        exporter.setParameter(JRXlsExporterParameter.IS_FONT_SIZE_FIX_ENABLED,true);
        exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED,true);
        exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_CELL_BACKGROUND,true);
        exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_CELL_BORDER,true);
        exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,true);
        exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,true);
        exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,false);
        
        exporter.exportReport();
        
        return baos.toByteArray();
    }
    
    public byte[] exportReportToCSV(JasperPrint jasperPrint) throws JRException
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
        JRCsvExporter exporter = new JRCsvExporter();
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
        exporter.setParameter(JRCsvExporterParameter.FIELD_DELIMITER,";");
        
        exporter.exportReport();
        
        return baos.toByteArray();
    }

    public byte[] exportReportToHTML(JasperPrint jasperPrint) throws JRException
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
        JRHtmlExporter exporter = new JRHtmlExporter();
        
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
        
        exporter.exportReport();
        
        return baos.toByteArray();
    }
    
}
