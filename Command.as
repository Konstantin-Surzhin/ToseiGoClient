package 
{

	public class Command
	{
		public static const S_COM:String = "_";
		public static const S_PAR:String = ";";


		public var phase:String = null;
		public var type:String = null;
		public var param:Array = null;

		

		public function Command(_phase:String = "", _type:String = "", _param:Array = null)
		{
			// constructor code
			phase = _phase;
			type = _type;
			if(_param == null)
				param = new Array();
			else param = _param;
		}

	}

}