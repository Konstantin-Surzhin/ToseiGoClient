package  {
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	
	public class SettingsReader {

		private const config:String = "config.txt";

		public function SettingsReader() {
			// constructor code
			var myTextLoader:URLLoader = new URLLoader();
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, error);
			try {
				myTextLoader.load(new URLRequest(config));
			} catch(er:IOError){}
			Info.log += "proc load";

		}
		
		function error(e:Event) {
			trace("er");
			Info.ip_serv = "127.0.0.1";
			if(Info.lan != null) Info.lan.ConnectToServer(); 
		}
		
		function onLoaded(e:Event):void {
			trace("loaded");
			Info.ip_serv = e.target.data;
			trace("ip " + Info.ip_serv);
			if(Info.lan != null) Info.lan.ConnectToServer();
			Info.log += "ip " + Info.ip_serv;
		}
		
		

	}
	
}
