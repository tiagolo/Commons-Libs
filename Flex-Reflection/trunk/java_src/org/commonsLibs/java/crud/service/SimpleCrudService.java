package org.commonsLibs.java.crud.service;

import java.util.Iterator;

import org.commonsLibs.java.dao.generic.AbstractDaoHibernate;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Repository
@RemotingDestination
@Service("simpleCrudService")
@Transactional(propagation=Propagation.SUPPORTS,rollbackFor=Exception.class)
public class SimpleCrudService extends AbstractDaoHibernate {
	
	
}
