package com.app.dao;

import java.util.ArrayList;
import java.util.List;

import org.commonsLibs.java.dao.generic.GenericDaoHibernate;
import org.hibernate.envers.AuditReader;
import org.hibernate.envers.AuditReaderFactory;
import org.springframework.stereotype.Repository;

import com.app.model.Item;

@Repository("ItemDao")
public class ItemDaoHibernate extends GenericDaoHibernate<Item> implements ItemDao {

	public List<Item> findAuditByID(Item entity)
	{
		AuditReader auditReader = AuditReaderFactory.get(getSession());
		
		List<Item> list = new ArrayList<Item>();
		
		for(Number number : auditReader.getRevisions(entity.getClass(), entity.getId()))
		{
			Item item = auditReader.find(entity.getClass(), entity.getId(),number);
			item.getFamilia().getItems().size();
			list.add(item);
		}
		
		return list;
	}
}
