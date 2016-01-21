package  {
	import fl.controls.List;
	import fl.core.UIComponent;

	public class Controller implements ControllerInterface {

		protected var lan:PlayerOnline = null;
		protected var gui:ControllerMainLine = null;

		public function Controller(_gui:ControllerMainLine) {
			// constructor code
			lan = new PlayerOnline(this);
			Info.lan = lan;
			gui = _gui;
		}
		
		public function Authorizate(name:String) {
			Info.login = name;
			lan.Authorizate(name); 
		}
		
		public function GetListPlayer(_str_find:String = "") {
			Info.lan.GetListPlayers(_str_find);
		}
		
		public function ChoosePlayer(_name_pl:String) {
			
			Info.lan.ChoosePlayer(_name_pl);
		}
		
		public function AgreeToPlay() {
			Info.lan.AgreeToPlay();
		}
		
		public function RefusedToPlay() {
			Info.lan.RefusedToPlay();
		}
		
		public function TouchMove(X:int, Y:int) {
			trace("control touch move");
			Info.desc_control.TouchMove(X, Y);
		}
		
		public function PushMove() {
			trace("control push move");
			Info.desc_control.SendMove();
		}
		
		public function Pass() {
			Info.desc_control.Pass();
			Info.lan.Pass();
		}
		
		public function CancelInvite() {
			Info.lan.CancelInvite();
		}
		
		public function ProcessCmd(cmd:Command) {
			trace("msg: phase: " + cmd.phase + " type: " + cmd.type + " param: " + cmd.param);
			
			switch(cmd.phase)
			{
				case Info.OTHER: {
					switch(cmd.type)
					{
						case "0": {
							//start app
							trace(cmd.param);
							Info.gui.GotoStartScreen();
							Info.gui.SetNumPlayer(cmd.param[1]);
						}break;
						case "1": {
							Info.lan.SendReply();
						}break;
					}
				} break;
				case Info.AUTHIRIZATION: {
					trace("auth");
					if(cmd.param == null) break;
					trace(cmd.param[0]);
					
					if( (cmd.param[0] as String) == "1") {
						trace("good auth");
						Info.gui.GotoChoosePlayer();
					} else if ( (cmd.param[0] as String) == "0" )  {
						trace("bad auth");
						Info.gui.ErrorAuth(1);
					} else if( (cmd.param[0] as String) == "2" ) {
						trace("bad auth");
						Info.gui.ErrorAuth(2);
					} else {
						trace("Warning! Parse in auth error (1)");
					}
				} break;
				case Info.IN_MENU: {
					trace("in menu");
					trace(cmd.type);
					switch(cmd.type)
					{
						case "1": {
							trace("params: " + cmd.param);
							cmd.param.pop();
							trace("param[0]: " + cmd.param[0]);
							Info.gui.SetNumPlayer(String(cmd.param[0]));
							cmd.param.shift();
							Info.gui.SetListPlayer(cmd.param);
						} break;
						case "2": {
							trace(cmd.param);
							Info.gui.AskToPlay(cmd.param[0]);
						} break;
						case "3": {
							if(cmd.param[0] == "1") 
							{
								if(cmd.param[1] == "1") {
									Info.color = Info.BLACK;
								} else if(cmd.param[1] == "0") {
									Info.color = Info.WHITE;
								} else trace("error! color notrecognized ");
								
								Info.gui.StartGame();
								
							} else if(cmd.param[0] == "0") 
							{
								Info.gui.GetRefusedToPlay();
							} else if(cmd.param[0] == "2") {
								Info.gui.GotoChoosePlayer();
							} else trace("Warning! Parse in menu error (3)");
						} break;
						default: trace("Warning! Parse in menu error (2)");
					}
					
				} break;
				case Info.PROCESS_GAME: {
					trace("process game");
					switch(cmd.type)
					{
						case "1": {
							trace("get move");
							var X:int = int(cmd.param[0]);
							var Y:int = int(cmd.param[1]);
							trace("X Y:" + X + Y);
							Info.desc_control.PutStoneOpponent(X, Y);
							Info.gui.SetQueue(Info.color);
						} break;
						case "2": {
							trace("pass");
							Info.desc_control.Pass();
							Info.gui.Pass();
							Info.gui.SetQueue(Info.color);
						} break;
						case "3": {
							trace("end game");
							Info.gui.EndGame();
						} break;
						
						case "4": {
							
						} break;
						case "5": {
							if(cmd.param[0] == 1) {
								Info.desc_control.ActivateStone();
								Info.gui.SetQueue(!Info.color);
							} else {
								Info.desc_control.DeactivateStone();
								Info.gui.SetGameLog("Bad Move!");			
							}
						} break;
						case "6": {
							trace("dif moves " + cmd.param);
							for(var i:uint = 0; i < cmd.param.length - 1; i += 3) {
								trace("delete x " + int(cmd.param[i]) + 
									  " y " + int(cmd.param[i + 1]) );
								Info.desc_control.DeleteStone(int(cmd.param[i]), 
															  int(cmd.param[i + 1]));
							}
						} break;
						case "7": {
							trace("get dif point " + cmd.param);
							Info.gui.SetPoint(int(cmd.param[0]), int(cmd.param[1]));
						} break;
					}
				} break;
				case Info.END_GAME: {
					trace("end game");
				} break;
			}
		}


	}
	
}
