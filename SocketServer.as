package 
{
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.net.XMLSocket;
	import flash.events.DataEvent;
	import fl.core.UIComponent;
	import flash.system.Security;
	import flash.utils.Timer;
	import flash.events.TimerEvent;



	public class SocketServer extends Sprite implements Server
	{

		private var socket:XMLSocket = new XMLSocket();
		protected var lan:PlayerOnline;

		public function SocketServer(_lan:PlayerOnline)
		{
			// constructor code
			lan = _lan;
			
			var timer:Timer = new Timer(1000);
			timer.addEventListener(Event.ACTIVATE, ConnectToServerTimer);
			timer.start();
			
			ConnectToServer();
			
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			this.socket.addEventListener(DataEvent.DATA, OnData);
			socket.addEventListener(Event.DEACTIVATE, BreakConnect);

		}

		private function BreakConnect(e:Event) {
			trace("break connect");
		}

		private function errorHandler(event:ErrorEvent):void
		{
			trace('Ошибка. error type='+event.type);
			Info.Log("Ошибка. error type=" + event.type);
			switch (event.type)
			{
				case IOErrorEvent.IO_ERROR :
					trace('Ошибка возникает когда по указанному хосту не удается найти сокет-сервер');
					Info.Log('Ошибка возникает когда по указанному хосту не удается найти сокет-сервер');
					
					break;
				case SecurityErrorEvent.SECURITY_ERROR :
					trace('Ошибка возникает когда срабатывает политика безопасности флешки. Сокет-сервер должен вернуть полиси-файл.');
					Info.Log('Ошибка возникает когда срабатывает политика безопасности флешки. Сокет-сервер должен вернуть полиси-файл.');
					
					break;
			}
		}

		private function OnData(event:DataEvent):void {
			trace("_______________________\n");
			trace("ss/get msg " + event.data);
			
			var str:String = event.data;
			var strs:Array = str.split(Command.S_COM);

			var param:Array = null;
			if(strs.length >= 3)
				param = (strs[2] as String).split(Command.S_PAR);
			
			var cmd:Command = new Command(strs[0], strs[1], param);
			lan.SendCmd(cmd);
		}

		private function dataHandler(event:ProgressEvent):void
		{
			trace("dataHandler");
			var str:String = new String();
			trace("get msg " + str);
		}

		private function connectHandler(event:Event):void
		{
			trace("connetion complete");
			dispatchEvent(new Events(Events.STATUS_CONNECT_SERVER));
			//socket.send("hello" + "\n");
		}

		protected function ConnectToServerTimer(ev:Event)
		{
			ConnectToServer();
		}

		public function GetConnect():Boolean {
			return socket.connected;
		}

		public function ConnectToServer():void
		{
			trace("try connect to server");
			
			if(Info.ip_serv == null) return;
			var host:String = Info.ip_serv;
			//var host:String = '188.227.19.61';
			var port:uint = 6000;

			if(!socket.connected) {
				dispatchEvent(new Events(Events.STATUS_CONNECT_SERVER));
				try {
					socket.connect(host,2500);
					Security.loadPolicyFile("xmlsocket://" + host + ":2500");
					trace("good");
				}  catch(e:Error) {
					trace("\n no policy find \n");
					Info.log.text += "no policy find \n";
				}
				
				try {
					socket.connect(host, port);
				}
				catch(er:Error) {Info.log.text += "\n err connect to host \n" + er.message;}
			}

		}

		protected function wr_str(str:String)
		{
			socket.send("_" + str + "\n");
			//socket.writeUTFBytes(str + "\n");
			//socket.flush();
		}

		public function SendCommand(cmnd:String, msg:String = "")
		{
			trace("ss/send com " + cmnd + " " + msg );
			wr_str(cmnd + "_" + msg + "_");
		}
		
		public function SendCmd(cmd:Command) {
			var param:String = new String();
			for(var i:uint = 0; i < cmd.param.length; i++) {
				param += cmd.param[i]
			}
			wr_str(cmd.phase + "_" + cmd.type + "_" + cmd.param);
		}

		public function Authorization(_login:String):int
		{
			trace("authorization");
			SendCommand("1", _login);
			return 0;
		}

		public function GetListPlayers(_str_find:String):void
		{
			trace("get list player");
			SendCommand("1", _str_find);
		}

		public function ChoosePlayer(_name_player:String):int
		{
			trace("choose player");
			return 0;
		}

		public function SendPass(row:int, column:int, type:int):int
		{
			trace("send pass");
			return 0;
		}

	}

}