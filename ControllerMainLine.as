package 
{
	import flash.display.MovieClip;
	import fl.controls.List;
	import fl.controls.TextInput;
	import fl.text.TLFTextField;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.StaticText;
	import flash.text.TextField;
	import fl.controls.Slider;


	public class ControllerMainLine
	{

		public function ControllerMainLine()
		{
			// constructor code
		}

		public function GotoStartScreen() {
			Info.main_timeline.gotoAndStop("screen_input");
			(Info.gl_stage.getChildByName("info") as DynamicInfo).timer_prog_bar.stop();
		}

		public function GotoChoosePlayer()
		{
			trace("gui goto choose pls");
			Info.control.GetListPlayer();
			Info.main_timeline.gotoAndStop("choose_player_screen");
		}
		
		public function StartGame() {
			(Info.gl_stage.getChildByName("info") as DynamicInfo).timer_prog_bar.stop();
			GotoGameScreen();
			if(Info.DEVICE == Info.WEB) 
			{
				if(Info.color == Info.BLACK) {
					(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip).
						send_move_white.enabled = false;
					(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip).
						send_move_black.enabled = true;
				} else {
					(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip).
						send_move_black.enabled = false;
					(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip).
						send_move_white.enabled = true;
				}
			}
			
		}
		
		protected function GotoGameScreen()
		{
			Info.main_timeline.gotoAndStop("game_screen");
		}
		
		public function SetListPlayer(list:Array) 
		{
			trace("set list player");
			var list_pls = Info.main_timeline.getChildByName("list_players");
			if(list_pls == null) {
				trace( "list_pls is null");
				return;
			}
			list_pls.removeAll();
			for( var i:int = 0; i < list.length; i++ ) {
				list_pls.addItem({label:list[i], data:i}); 
			}
		}
		
		public function SetNumPlayer(num:String) {
			trace("get num players: " + num);
			var tosey_lbl_start:MovieClip = Info.main_timeline.getChildByName("tosey_lbl") as MovieClip;
			var tosey_lbl_menu:MovieClip = Info.main_timeline.getChildByName("lbl_tosei_2") as MovieClip;
			if(tosey_lbl_start != null) tosey_lbl_start.num_players.text = num;
			if(tosey_lbl_menu != null) tosey_lbl_menu.num_players.text = num;
		}
		
		public function AskToPlay(_inviter:String) {
			//
			Info.inviter = _inviter;
			Info.main_timeline.gotoAndStop("ask_play");
		}
		
		public function GetRefusedToPlay() {
			GotoChoosePlayer();
		}
		
		public function AgreeToPlay() {
			Info.control.AgreeToPlay();
		}
		
		public function RefusedToPlay() {
			Info.control.RefusedToPlay();
			GotoChoosePlayer();
		}
		
		public function SetQueue(color:Boolean) {
			trace("set queue is " + color);
			if(color == Info.BLACK) {
				(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip).
					send_move_black.visible = true;
				(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip ).
					send_move_white.visible = false;
			}
			else {
				(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip ).
					send_move_black.visible = false;
				(Info.main_timeline.getChildByName("cur_move_lbl") as MovieClip ).
					send_move_white.visible = true;
			}
		}
		
		public function ChoosePlayer(ans:Boolean) {
			if(ans) {
				Info.control.ChoosePlayer(Info.choosed_player);
			} else {
				Info.gui.GotoChoosePlayer();
			}
		}
		
		public function Pass() {
			trace("gui pass");
			(Info.main_timeline.getChildByName("pass_clip") as MovieClip ).
				gotoAndPlay("start_play");
		}
		
		public function EndGame() {
			Info.main_timeline.gotoAndStop("end_game");
		}
		
		public function SetPoint(point:int, point_op:int) {
			trace("gui/set point " + point + " " + point_op);
			
			(Info.main_timeline.getChildByName("capture") as MovieClip).
				score_field_black.text = String(point);
			(Info.main_timeline.getChildByName("capture") as MovieClip).
				score_field_white.text = String(point_op);
		}
		
		public function SetGameLog(str:String) {
			if(Info.DEVICE == Info.WEB)
				(Info.main_timeline.getChildByName("log_game") as TextField).text = str;
		}
		
		public function ErrorAuth(codeEr:uint) {
			switch(codeEr)
			{
				case 1: {
					(Info.main_timeline.getChildByName("input_login") as MovieClip ).
							text_warning.gotoAndPlay("login_ocupped");
				} break;
				case 2: {
					(Info.main_timeline.getChildByName("input_login") as MovieClip ).
							text_warning.gotoAndPlay("short_login_error");
				} break;
			}
		}

	}

}