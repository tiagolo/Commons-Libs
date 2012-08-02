package org.commonsLibs.java.report.model;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Transient;

public class ReportFolder
{
	@Column
    private String label;
    
	@Transient
    private Collection<ReportFolder> children;
    
    public String getLabel()
    {
        return label;
    }
    public void setLabel(String label)
    {
        this.label = label;
    }
    public Collection<ReportFolder> getChildren()
    {
        return children;
    }
    public void setChildren(Collection<ReportFolder> children)
    {
        this.children = children;
    }

    public ReportFolder()
    {
        super();
    }
    
    public ReportFolder(String label, Collection<ReportFolder> children)
    {
        super();
        setLabel(label);
        setChildren(children);
    }
	
    @Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((label == null) ? 0 : label.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReportFolder other = (ReportFolder) obj;
		if (label == null) {
			if (other.label != null)
				return false;
		} else if (!label.equals(other.label))
			return false;
		return true;
	}
}
