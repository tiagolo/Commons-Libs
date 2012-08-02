package flexUnitTests.cases.model
{

	[Bindable]
	[RemoteClass(alias = "flexUnitTests.cases.model.Pessoa")]
	public class Pessoa
	{

		public var id:Number;

		public var nascimento:Date;

		public var nome:String;

		public function Pessoa()
		{
		}
	}
}
