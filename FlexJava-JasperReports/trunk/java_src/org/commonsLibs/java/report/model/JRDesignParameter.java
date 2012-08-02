package org.commonsLibs.java.report.model;

import java.util.ArrayList;
import java.util.List;

import net.sf.jasperreports.engine.JRPropertiesMap;

public class JRDesignParameter extends net.sf.jasperreports.engine.design.JRDesignParameter
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 2576940488575934283L;
	
	private List<JRDesignParameterProperty> properties;
    
    public List<JRDesignParameterProperty> getDesignProperties()
    {
        JRPropertiesMap propertiesMap = super.getPropertiesMap();
        properties = new ArrayList<JRDesignParameterProperty>();        
        
        for (String key : propertiesMap.getPropertyNames())
        {
            properties.add(new JRDesignParameterProperty(key, propertiesMap.getProperty(key)));
        }
        
        return properties;
    }

    public void setDesignProperties(List<JRDesignParameterProperty> properties)
    {
        this.properties = properties;
    }
} 
