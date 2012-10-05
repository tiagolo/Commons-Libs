package org.commonsLibs.dao.generic;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.hibernate.Session;

public abstract class GenericDaoHibernate<T> extends AbstractDaoHibernate implements GenericDao<T>
{
	private final Class<T> entityClass;

	@SuppressWarnings("unchecked")
	public GenericDaoHibernate()
	{
		this.entityClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	public Session getSession(Boolean allowCreate)
	{
		return super.getSession(allowCreate);
	}

	public Class<T> getEntityClass()
	{
		return entityClass;
	}

	public Serializable count() throws Exception 
	{
		return count(getEntityClass());
	}
	
	public List<T> find() throws Exception
	{
		return find(getEntityClass());
	}

	public List<T> find(int start, int length) throws Exception 
	{
		return find(getEntityClass(), start, length);
	}
	
	public T findById(Serializable id)
	{
	    return findById(getEntityClass(), id);
	}
	
	@SuppressWarnings("unchecked")
	public List<T> find(String queryString)
	{
		return (List<T>) super.find(queryString);
	}
}