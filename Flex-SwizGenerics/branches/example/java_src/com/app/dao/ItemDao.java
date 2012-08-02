package com.app.dao;

import java.util.List;

import org.commonsLibs.java.dao.generic.GenericDao;

import com.app.model.Item;

public interface ItemDao extends GenericDao<Item>{

	List<Item> findAuditByID(Item entity);

}
