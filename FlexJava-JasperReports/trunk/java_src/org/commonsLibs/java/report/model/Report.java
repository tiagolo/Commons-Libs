package org.commonsLibs.java.report.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="cl_jr_relatorios")
public class Report extends ReportFolder
{
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO,generator="cl_jr_seq_relatorios")
	@SequenceGenerator(name="cl_jr_seq_relatorios",sequenceName="cl_jr_seq_relatorios")
	private Integer id;
	
	@Column(unique=true)
    private String name;
	
	@Column
	private String label;
	
	@Column
    private String path;
    
	@Column
	private String aplicacao;
	
	@Column
	private byte[] jasperFile;
	
	@Column
	private byte[] jrxmlFile;
	
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getPath()
    {
        return path;
    }
    public void setPath(String path)
    {
        this.path = path;
    }

    public String getAplicacao()
    {
        return aplicacao;
    }
    public void setAplicacao(String aplicacao)
    {
        this.aplicacao = aplicacao;
    }
    
	public byte[] getJasperFile() {
		return jasperFile;
	}
	public void setJasperFile(byte[] jasperFile) {
		this.jasperFile = jasperFile;
	}
	public byte[] getJrxmlFile() {
		return jrxmlFile;
	}
	public void setJrxmlFile(byte[] jrxmlFile) {
		this.jrxmlFile = jrxmlFile;
	}
	public Report()
    {
        super();
    }

    public Report(String name,String label, String data)
    {
        super();
        
        setName(name);
        setLabel(label);
        setPath(data);
    }
}
