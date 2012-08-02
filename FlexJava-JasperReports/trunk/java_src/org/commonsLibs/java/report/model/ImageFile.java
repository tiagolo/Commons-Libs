package org.commonsLibs.java.report.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="cl_jr_imagens")
public class ImageFile {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO,generator="cl_jr_seq_imagens")
	@SequenceGenerator(name="cl_jr_seq_imagens",sequenceName="cl_jr_seq_imagens")
	private Integer id;
	
	@Column(unique=true)
	private String name;
	
	@Column
	private String path;
	
	@Column
	private byte[] bitmapData;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public byte[] getBitmapData() {
		return bitmapData;
	}

	public void setBitmapData(byte[] bitmapData) {
		this.bitmapData = bitmapData;
	}

	public ImageFile() {
		super();
	}

	public ImageFile(String name, String path) {
		super();
		this.name = name;
		this.path = path;
	}
	
	public ImageFile(String name, String path, byte[] bitmapData) {
		super();
		this.name = name;
		this.path = path;
		this.bitmapData = bitmapData;
	}


}
