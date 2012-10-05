package org.commonsLibs.util;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;

import flex.messaging.MessageException;

public class ExceptionTranslator implements
		org.springframework.flex.core.ExceptionTranslator {


	public boolean handles(Class<?> arg0) {
		return arg0.equals(DataIntegrityViolationException.class) || arg0.equals(HibernateOptimisticLockingFailureException.class);
	}
	
	public MessageException translate(Throwable arg0) {
		if(arg0 instanceof DataIntegrityViolationException)
		{
			return translateException((DataIntegrityViolationException) arg0);
		}
		else
		if(arg0 instanceof HibernateOptimisticLockingFailureException)
		{
			return translateException((HibernateOptimisticLockingFailureException)arg0);
		}
		return new MessageException(arg0);
	}

	private MessageException translateException(DataIntegrityViolationException arg0) {
		MessageException exception = new MessageException();
        exception.setCode(arg0.getClass().getName());
        exception.setMessage("A ação não pode executada devido a uma restrição vinculada a outros dados existentes, por favor remova as dependencias desse registro antes de prosseguir.");
        exception.setRootCause(arg0);
        return exception;
	}
	
	private MessageException translateException(HibernateOptimisticLockingFailureException arg0) {
		MessageException exception = new MessageException("Não foi possível realizar esta ação. O registro pode ter sido alterado por outro usuário neste momento.", arg0);
		exception.setCode(arg0.getClass().getName());
		return exception;
	}


}
