package org.commonsLibs.java.dao.generic;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.management.ReflectionException;
import javax.persistence.Column;
import javax.persistence.Id;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.orm.hibernate3.HibernateSystemException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

public abstract class AbstractDaoHibernate extends HibernateDaoSupport implements AbstractDao{

	//==============
	// Count
	//==============
	
	@RemotingInclude
	public <T> Serializable count(Class<T> entityClass) throws Exception {
		return count(entityClass.newInstance());
	}

	@RemotingInclude
	public <T> Serializable count(T entity) throws Exception {
		return count(entity, getEntityProperties(entity.getClass()));
	}

	@RemotingInclude
	public <T> Serializable count(T entity, String[] properties)
			throws Exception {
		Criteria criteria = createCriteria(entity, properties);
		criteria.setProjection(Projections.rowCount());
		return (Serializable) criteria.uniqueResult();
	}

	
	//==============
	// Find
	//==============
	
	@RemotingInclude
	public <T> List<T> find(Class<T> entityClass) {
		return getHibernateTemplate().loadAll(entityClass);
	}

	@RemotingInclude
	public <T> List<T> find(Class<T> entityClass, int start, int length)
			throws Exception {
		return find(entityClass.newInstance(), start, length);
	}

	@RemotingInclude
	public <T> List<T> find(T entity) throws Exception {
		if(entity instanceof String)
			find(Class.forName((String) entity));
		return find(entity, 0, 0);
	}

	@RemotingInclude
	public <T> List<T> find(T entity, int start, int length) throws Exception {
		return find(entity,getEntityProperties(entity.getClass()),start,length);
	}

	@RemotingInclude
	public <T> List<T> find(T entity, String[] properties) throws Exception {
		return find(entity,properties,0,0);
	}

	@RemotingInclude
	@SuppressWarnings({ "unchecked"})
	public <T> List<T> find(T entity, String[] properties, int start, int length)
			throws Exception {
		Criteria criteria = createCriteria(entity, properties);
		
		criteria.setFirstResult(start);
		
		if(length > 0)
		{
			criteria.setMaxResults(length);
			criteria.setFetchSize(length);
		}
		
		return criteria.list();
	}

	@RemotingInclude
	public <T> T findById(Class<T> entityClass, Serializable id) {
		try
	    {
	        return getHibernateTemplate().get(entityClass, id);
	    }catch (HibernateSystemException e) {
	        
	        if(id instanceof Integer)
	            return getHibernateTemplate().get(entityClass, ((Integer) id).longValue());
	        else if(id instanceof Long)
                return getHibernateTemplate().get(entityClass, ((Long) id).intValue());
            else
	            throw e;
        }
	}

	@RemotingInclude
	public List<?> find(String queryString) {
		return getHibernateTemplate().find(queryString);
	}
	
	
	//==============
	// Persistence
	//==============

	@RemotingInclude
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public <T> T merge(T entity) {
		return getHibernateTemplate().merge(entity);
	}

	@RemotingInclude
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public <T> Serializable save(T entity) {
		return getHibernateTemplate().save(entity);
	}

	@RemotingInclude
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public <T> void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	@RemotingInclude
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public <T> void remove(T entity) {
		getHibernateTemplate().delete(entity);
	}
	
	
	//==============
	// Reflection
	//==============
	
	@Autowired
    protected void setHibernateSessionFactory(@Qualifier("sessionFactory") SessionFactory sessionFactory)
    {
        setSessionFactory(sessionFactory);
    }
	
	protected <T> Criteria createCriteria(T entity, String[] properties) throws Exception
	{
		Criteria criteria = getSession().createCriteria(entity.getClass());
		
		if(properties != null)
		for (int i = 0; i < properties.length; i++)
		{
			String propertyName = properties[i];
			Object value = getValue(entity, propertyName);
			if(value instanceof String)
			{
				criteria.add(Property.forName(propertyName).like((String)value,MatchMode.ANYWHERE));
			}else if(value != null && !value.equals(0))
			{
				criteria.add(Property.forName(propertyName).eq(value));
			}
		}
		
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		
		return criteria;
	}
	
	protected String[] getEntityProperties(Class<?> entityClass)
	{
		List<String> properties = new ArrayList<String>();
		Field fields[] = entityClass.getDeclaredFields();
		for(int i = 0; i < fields.length; i++)
		{
			Field field = fields[i];
			if(field.getAnnotation(Column.class) != null || field.getAnnotation(Id.class) != null)
				properties.add(field.getName());
		}
		
		if(entityClass.getSuperclass() != null)
		for (String string : getEntityProperties(entityClass.getSuperclass()))
        {
            properties.add(string);
        }
		
		return properties.toArray(new String[0]);
	}
	
	protected <T> Object getValue(T entity, String propertyName)  
	{
		try {
			Method method = entity.getClass().getMethod(getGetter(propertyName));
			return method.invoke(entity);
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	protected String getGetter(String property)
    {
        return "get" + property.substring(0, 1).toUpperCase() + property.substring(1);
    }
}
