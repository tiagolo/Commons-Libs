package com.app.services;

import java.util.List;

import org.commonsLibs.java.services.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingExclude;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.app.dao.ItemDao;
import com.app.model.Item;

@Service("itemService")
@RemotingDestination
@Transactional(propagation=Propagation.SUPPORTS,rollbackFor=Exception.class)
public class ItemServiceImpl extends GenericServiceImpl<Item, ItemDao> implements ItemService{

	@Autowired
	private ItemDao dao;
	
	@Override
	@RemotingExclude
	public ItemDao getDao() {
		return dao;
	}

	@RemotingInclude
	public List<Item> findAuditByID(Item entity) {
		return dao.findAuditByID(entity);
	}
	
}
