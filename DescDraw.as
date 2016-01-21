package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.controls.progressBarClasses.IndeterminateBar;
	
	
	public class DescDraw extends MovieClip {		
		protected var dis_stone:Number = Info.INDENT_19x19;
		protected var size:int = 19;
		
		protected const EMPTY:int = 100500;
		protected var last_col = EMPTY;
		protected var last_row = EMPTY;
		protected var stones:Array;
		
		public function DescDraw() {
			// constructor code
			trace("dd/create");
			Info.desc_draw = this;
			stones = new Array(size);
			for(var i:uint = 0; i < size; i++ ) {
				stones[i] = new Array(size);
				for(var k:uint = 0; k < size; k++ ) {
					stones[i][k] = null;
				}
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE, AddToStage);
			trace("dd/end create");
		}
		
		public function Init() {
			trace("dd/init");
			for(var i:uint = 0; i < size; i++ ) {
				for(var k:uint = 0; k < size; k++ ) {
					CreateStone(i, k);
				}
			}
		}
		
		protected function AddToStage(event:Event) {
			trace("add desc on stage");
		}
				
		protected function CreateStone(col:int, row:int) {
			stones[col][row] = new Stone(Info.BLACK, col * dis_stone, row * dis_stone);
			addChild(stones[col][row]);
			( stones[col][row] as Stone ).visible = false;
		}
		
		public function Activate(col:int, row:int) {
			//trace("dd/activate stone");
			if(stones[col][row] == null) CreateStone(col, row);
			(stones[col][row] as Stone).Activate();
		}
		
		public function Deactivate(col:int, row:int) {
			//trace("dd/deactivate stone");
			(stones[col][row] as Stone).Deactivate();
		}
				
		public function GetActive(col:int, row:int):Boolean {
			//trace("dd/get activate " + col + " " + row + " " );
			var act:Boolean = (stones[col][row] as Stone).GetActivate();
			return act;
		}
		
		// delete stone from desc woth pos_x - column, pos_y - row
		public function RemoveStone(col:int, row:int) {
			//trace("dd/hide stone");
			(stones[col][row] as Stone).visible = false;
		}
				//add not activate stone
		public function AddStone(type:Boolean, col:int, row:int) {
			//trace("dd/show stone");
			(stones[col][row] as Stone).visible = true;
			(stones[col][row] as Stone).SetColor(type);
			
		}
		
		//add activate stone, not touch last stone
		public function AddActivateStone(type:Boolean, col:int, row:int) {
			//trace("dd/show activated stone");
			(stones[col][row] as Stone).SetColor(type);
			(stones[col][row] as Stone).Activate();
		}
		
	}
	
}
