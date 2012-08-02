package com.app.model.audit;

import org.hibernate.envers.RevisionListener;

public class BaseRevisionListener implements RevisionListener {

	@Override
	public void newRevision(Object entity) {
		BaseRevisionEntity revisionEntity = (BaseRevisionEntity) entity;
		
		revisionEntity.setUsername("Tiago Lopes");
	}

}
