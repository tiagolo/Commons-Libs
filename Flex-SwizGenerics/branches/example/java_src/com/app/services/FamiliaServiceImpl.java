package com.app.services;

import org.commonsLibs.java.services.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingExclude;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.app.dao.FamiliaDao;
import com.app.model.Familia;

@Service("familiaService")
@RemotingDestination
@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
public class FamiliaServiceImpl extends GenericServiceImpl<Familia, FamiliaDao> implements FamiliaService{

	@Autowired
	private FamiliaDao dao;
	
	@Override
	@RemotingExclude
	public FamiliaDao getDao() {
		return dao;
	}
}
