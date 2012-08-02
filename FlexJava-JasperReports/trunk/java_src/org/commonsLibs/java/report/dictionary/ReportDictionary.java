package org.commonsLibs.java.report.dictionary;

import java.io.File;

import flex.messaging.FlexContext;

public class ReportDictionary {
	
	public static String reportPath = System.getProperty("catalina.home") + File.separator + "CommonsLibs" + File.separator + "relatorios" + File.separator;
	public static String path = FlexContext.getServletContext().getContextPath();
}
