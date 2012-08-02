package flexUnitTests
{
	import com.app.business.SimpleCrudManager;
	import com.app.model.Pessoa;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;
	import org.commonsLibs.crud.SimpleCrudFactory;
	import org.swizframework.utils.services.ServiceHelper;

	public class PessoaManagerTest
	{

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		public var pessoaManager:SimpleCrudManager;

		[Before]
		public function setUp():void
		{
			var factory:SimpleCrudFactory = new SimpleCrudFactory();
			factory.createView(Pessoa);

			pessoaManager = new SimpleCrudManager();
			pessoaManager.entity = Pessoa;
			pessoaManager.service = new RemoteObject("simpleCrudService");
			pessoaManager.service.addEventListener(FaultEvent.FAULT, faultHandler);
			pessoaManager.serviceHelper = new ServiceHelper();

		}

		[After]
		public function tearDown():void
		{
		}

		[Test]
		public function testFind():void
		{
			pessoaManager.find();
		}

		[Test]
		public function testSave():void
		{
			var pessoa:Pessoa = new Pessoa();
			pessoa.nome = "Rafael Cunha";
			pessoa.nascimento = new Date(1982, 08, 22);

			pessoaManager.save(pessoa, []);
		}

		protected function faultHandler(event:FaultEvent):void
		{
			trace(event);
		}
	}
}
