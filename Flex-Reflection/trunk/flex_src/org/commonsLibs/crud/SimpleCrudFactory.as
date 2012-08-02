package org.commonsLibs.crud
{
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import mx.containers.ViewStack;
	import mx.core.Container;
	import flex.lang.reflect.builders.FieldBuilder;
	import flex.lang.reflect.builders.MetaDataAnnotationBuilder;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import org.commonsLibs.reflection.TypeDescriptor;
	import spark.components.DataGrid;
	import spark.components.Form;
	import spark.components.Group;
	import spark.components.NavigatorContent;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalLayout;

	public class SimpleCrudFactory
	{
		public function SimpleCrudFactory()
		{
		}

		public function createView(entity:*):Container
		{
			var describeType:XML = flash.utils.describeType(entity);

			//CommonsLibs Reflection
			var typeDesc:TypeDescriptor = new TypeDescriptor(entity, ApplicationDomain.currentDomain);
			trace(typeDesc.getClassName());
			trace(typeDesc.getMetadataTags());

			//Swiz Reflection
			/*
			var typeDescriptor:TypeDescriptor = new TypeDescriptor();
			var currentDomain:ApplicationDomain = ApplicationDomain.currentDomain;

			if (entity is Class)
			{
				typeDescriptor.fromXML(describeType2, currentDomain);
			}
			else if (entity)
			{
				var definition:Object = getDefinitionByName(getQualifiedClassName(entity));
			}
			*/

			//FlexUnit Reflection
			var metadata:MetaDataAnnotation = new MetaDataAnnotation(describeType.factory.metadata[0]);
			var metaBuilder:MetaDataAnnotationBuilder = new MetaDataAnnotationBuilder(describeType);
			var buildAllAnnotations:Array = metaBuilder.buildAllAnnotations();

			var fieldBuilder:FieldBuilder = new FieldBuilder(describeType, entity as Class);
			var buildAllFields:Array = fieldBuilder.buildAllFields();


			var mainView:ViewStack = new ViewStack();

			var listView:NavigatorContent = new NavigatorContent();
			listView.layout = new VerticalLayout();
			mainView.addElement(listView);

			var listForm:Form = new Form();
			listForm.percentWidth = 100;
			listView.addElement(listForm);

			var listDataGrid:DataGrid = new DataGrid();
			listView.addElement(listDataGrid);

			var listControlBar:Group = new Group();
			listControlBar.layout = new HorizontalLayout();
			listView.addElement(listControlBar);

			var editView:NavigatorContent = new NavigatorContent();
			editView.layout = new VerticalLayout();
			mainView.addElement(editView);

			return mainView;
		}
	}
}
