package  {
	import flash.events.Event;
	
	public class Events extends Event {
		public static const STATUS_CONNECT_SERVER:String = "STATUS_CONNECT_SERVER";
		public static const MOVE_SLIDER:String = "MOVE_SLIDER";
		public static const RELEASE_SLIDER:String = "RELEASE_SLIDER";
		
		public var status_connnect:Boolean;
		public var cur_pos_slider:int = 0;

		public function Events(type:String) {
			// constructor code
			super(type);
		}

	}
	
}
