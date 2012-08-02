package org.commonsLibs.java.dao.generic;

import java.io.Serializable;
import java.util.List;


public interface AbstractDao {

	public <T> Serializable count(Class<T> entityClass) throws Exception;
	public <T> Serializable count(T entity) throws Exception;
	public <T> Serializable count(T entity, String[] properties) throws Exception;
	
	public <T> List<T> find(Class<T> entityClass);
	public <T> List<T> find(Class<T> entityClass, int start, int length) throws Exception;
	public <T> List<T> find(T entity) throws Exception;
	public <T> List<T> find(T entity,int start, int length) throws Exception;
	public <T> List<T> find(T entity, String[] properties) throws Exception;
	public <T> List<T> find(T entity, String[] properties,int start, int length) throws Exception;
	
	public <T> T findById(Class<T> entityClass, Serializable id);
	public List<?> find(String queryString);
	
	public <T> T merge(T entity);
	public <T> Serializable save(T entity);
	public <T> void update(T entity);
	public <T> void remove(T entity);
	
}
