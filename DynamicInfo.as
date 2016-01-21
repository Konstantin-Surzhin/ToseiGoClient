package  {
	import flash.display.Sprite;
	import flash.utils.Timer;
	
	public class DynamicInfo extends Sprite {

		public function DynamicInfo()  {
			// constructor code
			name = "info";
		}
		
		public var timer_prog_bar:Timer = new Timer(50);
		public var lan:PlayerOnline = null;

	}
	
}
