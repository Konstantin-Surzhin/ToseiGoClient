/** @brief main game class
*	ver 1.0.0.1
*/

package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.Socket;
	import fl.text.TLFTextField;

	public class MainGame extends MovieClip
	{
		public var log:TLFTextField = new TLFTextField();
		public function MainGame()
		{
			// constructor code
			trace("start app");
			
			//var sett:SettingsReader = new SettingsReader();
			Info.ip_serv = "185.98.87.71";
			//Info.ip_serv = "127.0.0.1";
			log = new TLFTextField();
			Info.log = log;
			try {
				Info.Init();
				stage.addChild(Info.lan);
			} catch(er:Error){Info.log.text += "error init";}
			this.addEventListener(Event.ADDED_TO_STAGE, add_to_stage);

		}

		public function add_to_stage(event:Event)
		{
			var info:DynamicInfo = new DynamicInfo();
			info.lan = Info.lan;
			stage.addChild(info);
			Info.gl_stage = stage;
			
			//stage.addChild(log);
			log.textColor = 0xFFFFFF;
			log.x = 35;
			log.y = 530;
			log.width = 800;
			log.height = 200;
			
			Info.log = log;
		}
	}
}