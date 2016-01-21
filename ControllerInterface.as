package  {
	
	public interface ControllerInterface {

		// Interface methods:
		function Authorizate(name:String);
		function ProcessCmd(cmd:Command);
		function GetListPlayer(_str_find:String = "");
		function AgreeToPlay();
		function RefusedToPlay();
		function ChoosePlayer(_name_pl:String);
		function PushMove();
		function TouchMove(X:int, Y:int);
		function Pass();
		function CancelInvite();
	}
	
}
