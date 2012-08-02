package org.commonsLibs.java.util;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Transient;

import org.hibernate.LazyInitializationException;
import org.hibernate.collection.PersistentBag;

import flex.messaging.messages.Message;
import flex.messaging.services.remoting.adapters.JavaAdapter;

@SuppressWarnings({"unchecked","rawtypes"})
public class LazyJavaAdapter extends JavaAdapter
{
	@Override
	public Object invoke(Message arg0)
	{
		Object invoke = super.invoke(arg0);

        nullateLazyBag(invoke, new ArrayList<Object>());

        return invoke;
    }

	private void nullateLazyBag(Object result,List<Object> lazyStack)
    {
        if (result instanceof Collection)
        {
            for (Object o : (Collection) result)
            {
                nullateLazyBag(o,lazyStack);
            }
        }
        else if (result != null && !isEntity(result.getClass()))
        {
            return;
        }
        else
        {
            if (result != null)
            {
                if (!lazyStack.contains(result))
                {
                    lazyStack.add(result);
                    Field[] fields = getNoTransientFields(result.getClass());
                    for (Field field : fields)
                    {
                        Object invoke = invoke(result, field.getName());
                        if (invoke == null)
                        {
                            continue;
                        }
                        else
                        {
                            if (invoke instanceof PersistentBag && !((PersistentBag) invoke).wasInitialized())
                            {
                            	// se for um bolsa vazia, anule-a
                                nullate(result, field.getName());
                            }
                            else if (isEntity(invoke.getClass()) || (invoke instanceof PersistentBag && ((PersistentBag) invoke).wasInitialized()))
                            {
                                if (!lazyStack.contains(invoke))
                                {
                                    nullateLazyBag(invoke,lazyStack);
                                }
                            }
                            else if (invoke instanceof Collection)
                            {
                                nullateLazyBag(invoke,lazyStack);
                            }
                        }
                    }
                    lazyStack.remove(result);
                }
            }
        }
    }

	private void nullate(Object entity, String property)
    {
        Class clazz = entity.getClass();

        // Necessário testar o tipo de argumento que o setter recebe
        // Algumas persistentBag foram mapeadas como List e outras como Collection
        try
        {
            Method method = clazz.getMethod(getSetter(property), new Class[]
                {
                    List.class
                });
            method.invoke(entity, new Object[]
                {
                    null
                });
        }
        catch (Exception e)
        {
            try
            {

                Method method = clazz.getMethod(getSetter(property), new Class[]
                    {
                        Collection.class
                    });
                method.invoke(entity, new Object[]
                    {
                        null
                    });
            }
            catch (Exception e1)
            {
                try
                {
                    Method method = clazz.getMethod(getSetter(property), new Class[]
                        {
                            invoke(entity, property).getClass()
                        });
                    method.invoke(entity, new Object[]
                        {
                            null
                        });
                }
                catch (Exception e2)
                {
                    // em caso de não existir o método. Praticamente impossível, já que estou trazendo um método preexistente
                    e.printStackTrace();
                }
            }
        }
    }

	private Field[] getNoTransientFields(Class clazz)
    {
    	Field[] notTransientFields = {};
        Collection<Field> fieldsCollection = new ArrayList<Field>();
        for (int i = 0; i < clazz.getDeclaredFields().length; i++)
        {
            boolean isTransient = false;
            Field field = clazz.getDeclaredFields()[i];
            Annotation[] annotations = field.getAnnotations();
            for (int j = 0; j < annotations.length; j++)
            {
                if (annotations[j].annotationType() == Transient.class)
                    isTransient = true;
            }
            if (!isTransient)
            {
                fieldsCollection.add(field);
            }
        }
        
        if(clazz.getSuperclass().getDeclaredFields().length > 0)
        {
        	fieldsCollection.addAll(Arrays.asList(getNoTransientFields(clazz.getSuperclass())));
        }
        
        notTransientFields = (Field[]) fieldsCollection.toArray(notTransientFields);
        return notTransientFields;
    }

    private String getGetter(String property)
    {
        return "get" + property.substring(0, 1).toUpperCase() + property.substring(1);
    }

    private String getSetter(String property)
    {
        return "set" + property.substring(0, 1).toUpperCase() + property.substring(1);
    }

	private Object invoke(Object entity, String property)
    {
        Class clazz = entity.getClass();

        Object invocation = null;
        try
        {
        	if(!property.equals("serialVersionUID"))
        	{
	            Method method = null;
	            method = clazz.getMethod(getGetter(property));
	            invocation = method.invoke(entity);
        	}
        }
        catch (LazyInitializationException e)
        {
            throw new LazyInitializationException("");
        }
        catch (Exception e)
        {
            // em caso de não existir o método. Praticamente impossível, já que estou trazendo um método preexistente
            e.printStackTrace();
        }
        return invocation;
    }

	private boolean isEntity(Class clazz)
    {
        boolean result = false;
        for (int i = 0; i < clazz.getAnnotations().length; i++)
        {
            Annotation annotation = clazz.getAnnotations()[i];
            if (annotation.annotationType() == Entity.class)
            {
                result = true;
            }
        }
        return result;
    }
}
