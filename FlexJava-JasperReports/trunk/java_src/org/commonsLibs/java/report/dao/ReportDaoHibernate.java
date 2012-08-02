/**
 * 
 */
package org.commonsLibs.java.report.dao;

import org.commonsLibs.java.dao.generic.GenericDaoHibernate;
import org.commonsLibs.java.report.model.Report;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author tiagolo
 *
 */
@Repository
@Transactional(propagation=Propagation.SUPPORTS,rollbackFor=Exception.class)
public class ReportDaoHibernate extends GenericDaoHibernate<Report> implements
		ReportDao {

	
	
}
