package  {
	
	import flash.display.MovieClip;
	
	
	public class Stone extends MovieClip {
		protected var color:Boolean = false;
		protected var activate:Boolean = false;
		
		public var col_pos:int;
		public var row_pos:int;

		public function Stone(type:Boolean, pos_x:Number = 0, pos_y:Number = 0) {
			// constructor code
			if(type) this.gotoAndStop("black");
			else this.gotoAndStop("white");
			color = type;
			this.x =  pos_x;
			this.y = pos_y;
			Deactivate();
		}
		
		public function SetColor(_color:Boolean) {
			color = _color;
			if(color == Info.BLACK) this.gotoAndStop("black");
			else this.gotoAndStop("white");
			Deactivate();
		}
		
		public function Activate() {
			//trace("activate stone");
			if(color == Info.BLACK) this.gotoAndStop("black");
			else this.gotoAndStop("white");
			activate = true;
			visible = true;
		}
		
		public function GetActivate():Boolean {
			return activate;
		}
		
		public function Deactivate() {
			//trace("deactivate stone");
			Activate();
			this.nextFrame();
			activate = false;
		}
	}
	
}
