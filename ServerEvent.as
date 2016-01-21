package  {
	import flash.events.Event;
	
	public class ServerEvent extends Event{
		public static const SERVER_ANSER:String = "SERVER_ANSWER";
		public var code_answer:int = 0;
		public var list_player:Array = null;

		public function ServerEvent(type:String,
									bubbles:Boolean = false,
									cancelable:Boolean = false) {
			// constructor code
			super(type, bubbles, cancelable);
		}

	}
	
}
