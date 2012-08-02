package flexUnitTests.cases
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.system.ApplicationDomain;
	import mx.core.Application;
	import mx.events.FlexEvent;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flexUnitTests.cases.model.Pessoa;
	import org.commonsLibs.crud.SimpleCrudFactory;
	import org.commonsLibs.reflection.TypeDescriptor;

	public class ReflectionTestCase
	{

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		private var simpleCrudFactory:SimpleCrudFactory

		[Before]
		public function setUp():void
		{
			simpleCrudFactory = new SimpleCrudFactory();
		}

		[After]
		public function tearDown():void
		{
		}

		//[Test]
		public function testCreateView():void
		{
			simpleCrudFactory.createView(Pessoa);
		}

		[Test]
		public function testReflectionComplex():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest(IResourceManager)
			trace("testReflectionComplex", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
			//Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, typeDescriptor.description);

		}


		[Test]
		public function testReflectionWithClass():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest(Pessoa)
			trace("testReflectionWithClass", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
		}

		[Test]
		public function testReflectionWithInstance():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest(new Pessoa())
			trace("testReflectionWithInstance", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
		}

		[Test]
		public function testReflectionWithQualifiedName():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest("flexUnitTests.cases.model.Pessoa")
			trace("testReflectionWithQualifiedName", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
		}

		[Test]
		public function testReflectionWithQualifiedName2():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest("flexUnitTests.cases.model::Pessoa")
			trace("testReflectionWithQualifiedName2", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
		}

		[Test]
		public function testReflectionWithQualifiedName3():void
		{
			var typeDescriptor:TypeDescriptor = baseReflectionTest("Pessoa")
			trace("testReflectionWithQualifiedName3", typeDescriptor.getClassName(), typeDescriptor.getMetadataTags());
		}

		private function baseReflectionTest(value:*):TypeDescriptor
		{
			var typeDescriptor:TypeDescriptor = new TypeDescriptor(value, ApplicationDomain.currentDomain);

			return typeDescriptor;
		}
	}
}
