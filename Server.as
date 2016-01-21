package  {
	
	public interface Server {

		// Interface methods:
		function ConnectToServer():void;
		function Authorization(_name_player:String):int;
		function GetListPlayers(_str_find:String):void;
		function ChoosePlayer(_name_player:String):int;
		function SendPass(row:int, column:int, type:int):int;
		
	}
	
}
