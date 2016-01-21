package 
{
	import flash.display.Sprite;

	public class PlayerOnline extends Sprite
	{
		protected var server:SocketServer;
		protected var control:ControllerInterface;

		public function PlayerOnline(_control:ControllerInterface)
		{
			// constructor code
			control = _control;
			server = new SocketServer(this);
			server.ConnectToServer();
		}

		public function SendCmd(cmd:Command)
		{
			control.ProcessCmd(cmd);
		}

		public function Authorizate(_p_name:String)
		{
			server.Authorization(_p_name);
		}

		public function GetListPlayers(_str_find:String):void
		{
			server.GetListPlayers(_str_find);
		}

		public function ChoosePlayer(_name_pl:String)
		{
			
			trace("login finded " + _name_pl);
			server.SendCommand("2", _name_pl);
		}
		
		public function AgreeToPlay():void {
			server.SendCommand("3", "1");
		}
		
		public function RefusedToPlay():void {
			server.SendCommand("3", "0");
		}
		
		public function SendMove(X:int, Y:int) {
			server.SendCommand( "1", String(X) + ";" + String(Y));
		}
		
		public function SendReply() {
			server.SendCommand("0");
		}
		
		public function Pass() {
			server.SendCommand("2");
		}
		
		public function CancelInvite() {
			server.SendCommand("3", "2");
		}
		
		public function ConnectToServer() {
			server.ConnectToServer();
		}
		
		public function GetConnect() :Boolean {
			return server.GetConnect();
		}

	}

}