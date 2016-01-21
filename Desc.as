package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fl.controls.progressBarClasses.IndeterminateBar;
	
	public class Desc extends MovieClip {
		//protected var Info.desc_draw:DescDraw = null;
		//contain table desc
		protected var moves:Array;
		public var steps:Array;
		protected var last_c:uint = EMPTY;
		protected var last_r:uint = EMPTY;
		protected var size_desc:uint = 19;
		
		protected static const EMPTY:int = 100500;

		public function Desc() {
			// constructor code
			trace("d/create");
			Info.desc_control = this;
			//this.Info.desc_draw = _Info.desc_draw;
			steps = new Array();
			size_desc = 19;
			moves = new Array(size_desc);
			for(var i:uint = 0; i < size_desc; i++ ) {
				moves[i] = new Array(size_desc);
				for(var k:uint = 0; k < size_desc; k++ ) {
					moves[i][k] = EMPTY;
				}
			}
			
			//Info.desc_draw.addEventListener(MouseEvent.CLICK, mouse_click);
			trace("d/end create");
		}
		
		protected function mouse_click(event:MouseEvent) {
			trace("click");
		}
		
		// put activate stone opponent
		public function PutStoneOpponent(column:int, row:int) {
			trace("put stone | desc");
			steps.push(new Point(column, row));
			moves[column][row] = !Info.color;
			Info.desc_draw.AddActivateStone(!Info.color, column, row);
			SetGameLog(row, column);
		}
		
		// activate last added stone
		public function ActivateStone() {
			trace("d/activate stone");
			if(last_c == EMPTY && last_r == EMPTY) return;

			steps.push(new Point(last_c, last_r));
			Info.desc_draw.Activate(last_c, last_r);
			moves[last_c][last_r] = Info.color;
			SetGameLog(last_r, last_c);
			last_c = EMPTY;
			last_r = EMPTY;
		}
		
		private function SetGameLog(row:int, col:int) {
			var n_last_r:int = size_desc - row;
			var n_last_c:int = col;
			if(n_last_c > 8) n_last_c++;
			Info.gui.SetGameLog(String.fromCharCode(n_last_c + 65) + "" + String(n_last_r) );
		}
		
		//deactivate last stone
		public function DeactivateStone() {
			trace("d/deactivate stone");
			if(last_c == EMPTY && last_r == EMPTY) return;
			
			//Info.desc_draw.Deactivate(last_c, last_r);
			Info.desc_draw.RemoveStone(last_c, last_r);
			moves[last_c][last_r] = EMPTY;
			last_c = EMPTY;
			last_r = EMPTY;

		}
		
		public function MoveLastStone(col:int, row:int) {
			if(last_c + col > 0 &&
			   last_c + col <= size_desc &&
			   last_r + row > 0 &&
			   last_r + row <= size_desc ) 
		   {
			   TouchMove(last_c + col, last_r + row);
		   }
		}
		
		// add not activated stone
		public function TouchMove(column:int, row:int) {
			if(moves[column][row] != EMPTY) return;
			
			if(last_c != EMPTY && last_r != EMPTY) {
				if( !Info.desc_draw.GetActive(last_c, last_r) ) {
					Info.desc_draw.RemoveStone(last_c, last_r);
				}	
			}
			
			this.last_c = column;
			this.last_r = row;
			
			Info.desc_draw.AddStone(Info.color, column, row);
			if(Info.touch_move) {
				SendMove();
			}
		}
		
		//send activated stone
		public function SendMove() {
			if(last_c == EMPTY && last_r == EMPTY) return;
			if(moves[last_c][last_r] != EMPTY) return;
			
			trace("send move " + last_c + " " + last_r);

			Info.lan.SendMove(last_c, last_r);
		}
		
		//delete stone from desc
		public function DeleteStone(col:int, row:int) {
			if(col < this.size_desc && col >= 0 && row < size_desc && row >= 0) {
				Info.desc_draw.RemoveStone(col, row);
				moves[col][row] = EMPTY;
			}
		}
		
		public function Pass() {
			steps.push(new Point(-2, -2));
			Info.gui.SetGameLog("You: Passed");			
		}
		
		//put not activated stone stone
		public function PutStone(column:int, row:int) {
			if(moves[column][row] != EMPTY) return;
			trace("d/put stone");
			
			moves[column][row] = Info.color;
			Info.lan.SendMove(column, row);
			Info.desc_draw.AddStone(Info.color, column, row);
		}

	}
	
}
