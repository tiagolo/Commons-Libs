package org.commonsLibs.services.generic;

import java.io.Serializable;
import java.util.List;

import org.commonsLibs.dao.generic.GenericDao;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Transactional(propagation = Propagation.SUPPORTS, rollbackFor = Exception.class)
public abstract class AbstractServiceImpl<T, D extends GenericDao<T>>
		implements AbstractService<T> {
	public abstract D getDao();

	@RemotingInclude
	public Serializable count() throws Exception {
		return getDao().count();
	}

	@RemotingInclude
	public Serializable count(T entity) throws Exception {
		return getDao().count(entity);
	}

	@RemotingInclude
	public Serializable count(T entity, String[] properties) throws Exception {
		return getDao().count(entity, properties);
	}

	@RemotingInclude
	public List<T> find() throws Exception {
		return getDao().find();
	}

	@RemotingInclude
	public List<T> find(int start, int length) throws Exception {
		return getDao().find(start, length);
	}

	@RemotingInclude
	public List<T> find(T entity) throws Exception {
		return getDao().find(entity);
	}

	@RemotingInclude
	public List<T> find(T entity, int start, int length) throws Exception {
		return getDao().find(entity, start, length);
	}

	@RemotingInclude
	public List<T> find(T entity, String[] properties) throws Exception {
		return getDao().find(entity, properties);
	}

	@RemotingInclude
	public List<T> find(T entity, String[] properties, int start, int length)
			throws Exception {
		return getDao().find(entity, properties, start, length);
	}

	@RemotingInclude
	public T findById(Serializable id) {
		return getDao().findById(id);
	}

	@RemotingInclude
	public List<T> find(String queryString) {
		return getDao().find(queryString);
	}

	@RemotingInclude
	@Transactional(propagation = Propagation.REQUIRED)
	public T merge(T entity) {
		return getDao().merge(entity);
	}

	@RemotingInclude
	@Transactional(propagation = Propagation.REQUIRED)
	public Serializable save(T entity) {
		return getDao().save(entity);
	}

	@RemotingInclude
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveOrUpdate(T entity) {
		getDao().saveOrUpdate(entity);
	}

	@RemotingInclude
	@Transactional(propagation = Propagation.REQUIRED)
	public void update(T entity) {
		getDao().update(entity);
	}

	@RemotingInclude
	@Transactional(propagation = Propagation.REQUIRED)
	public void remove(T entity) {
		getDao().remove(entity);
	}
}
