package org.commonsLibs.java.services.generic;

import java.io.Serializable;
import java.util.List;

public interface GenericService<T>
{
	public Serializable count() throws Exception;
	public Serializable count(T entity) throws Exception;
	public Serializable count(T entity, String[] properties) throws Exception;
	
	public List<T> find() throws Exception;
	public List<T> find(int start, int length) throws Exception;
	public List<T> find(T entity) throws Exception;
	public List<T> find(T entity,int start, int length) throws Exception;
	public List<T> find(T entity, String[] properties) throws Exception;
	public List<T> find(T entity, String[] properties,int start, int length) throws Exception;
	
	public T findById(Serializable id);
	public List<T> find(String queryString);
	
	public T merge(T entity);
	public Serializable save(T entity);
	public void update(T entity);
	public void remove(T entity);

}
