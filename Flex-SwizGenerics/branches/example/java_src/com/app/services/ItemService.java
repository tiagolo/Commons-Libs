package com.app.services;

import java.util.List;

import org.commonsLibs.java.services.generic.GenericService;

import com.app.model.Item;

public interface ItemService extends GenericService<Item>{

	List<Item> findAuditByID(Item entity);

}
