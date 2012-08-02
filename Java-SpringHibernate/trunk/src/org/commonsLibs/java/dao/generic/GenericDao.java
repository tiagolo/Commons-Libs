package org.commonsLibs.java.dao.generic;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

public interface GenericDao<T> extends AbstractDao
{
    public HibernateTemplate getHibernateTemplate();
	public SessionFactory getSessionFactory();
	public Session getSession(Boolean allowCreate);
	public Class<T> getEntityClass();
	
	public Serializable count() throws Exception;
	
	public List<T> find() throws Exception;
	public List<T> find(int start, int length) throws Exception;
	
	public T findById(Serializable id);
	public List<T> find(String queryString);
}
