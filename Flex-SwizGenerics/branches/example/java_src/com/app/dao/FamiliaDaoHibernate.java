package com.app.dao;

import org.commonsLibs.java.dao.generic.GenericDaoHibernate;
import org.springframework.stereotype.Repository;

import com.app.model.Familia;

@Repository("FamiliaDao")
public class FamiliaDaoHibernate extends GenericDaoHibernate<Familia> implements FamiliaDao {

    public Familia save(Familia entity)
    {
       return merge(entity);
    }
    
}
