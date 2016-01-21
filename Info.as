
package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import fl.text.TLFTextField;

	public class Info
	{
		public static const OTHER:String = "0";
		public static const AUTHIRIZATION:String = "1";
		public static const IN_MENU:String = "2";
		public static const PROCESS_GAME:String = "3";
		public static const END_GAME:String  = "4";
		
		public static const MOBILE:uint = 0;
		public static const WEB:uint = 1;
		public static const DEVICE:uint = WEB;

		//indent beerwin row and columns on desk
		static const INDENT_19x19:Number = 23.4;
		static const INDENT_13x13:Number = 34.2;
		static const INDENT_9x9:Number = 49.4;

		static const DESC_9x9:int = 1;
		static const DESC_13x13:int = 2;
		static const DESC_19x19:int = 3;

		//stone
		static const BLACK:Boolean = true;
		static const WHITE:Boolean = false;

		static var desc_draw:DescDraw = null;
		static var desc_control:Desc = null;
		static var color:Boolean = BLACK;
		static var lan:PlayerOnline = null;

		static var choosed_player:String = new String();
		static var inviter:String = new String();
		
		
		static var ip_serv:String = null;
		
		static var login:String = null;
		static var login_opponent:String = null;
		static var main_timeline:MovieClip = null;
		static var gui:ControllerMainLine = null;
		static var control:ControllerInterface = null;
		static var list_players:Array = null;
		static var log = null;
		static var gl_stage = null;
		static var touch_move:Boolean = false;
		
		public static function Log(str:String) {
			//if(Info.log != null) Info.log.text += str;
		}

		public function Info()
		{
			// constructor code
		}
				
		public static function Init() {
			try {gui = new ControllerMainLine();}
			catch(er:Error) {log.text += "error gui";}
			try{control = new Controller(gui);}
			catch(er:Error) {log.text += "error control";}

		}

	}

}