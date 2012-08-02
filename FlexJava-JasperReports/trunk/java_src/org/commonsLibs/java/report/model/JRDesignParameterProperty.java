package org.commonsLibs.java.report.model;

import java.io.Serializable;

public class JRDesignParameterProperty implements Serializable
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -1246444214065738419L;
	
	private String label;
    private String data;

    public String getLabel()
    {
        return label;
    }

    public void setLabel(String label)
    {
        this.label = label;
    }

    public String getData()
    {
        return data;
    }

    public void setData(String data)
    {
        this.data = data;
    }

    public JRDesignParameterProperty(String label, String data)
    {
        super();
        this.label = label;
        this.data = data;
    }

}
