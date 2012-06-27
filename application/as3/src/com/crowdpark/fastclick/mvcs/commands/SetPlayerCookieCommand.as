package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Command;

	import flash.net.SharedObject;

	/**
	 * @author fatmatekin
	 */
	public class SetPlayerCookieCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var gameEvents : GameEvents;

		override public function execute() : void
		{
			var data : PlayerVo = PlayerVo(gameEvents.getDataprovider());
			var flashCookie : SharedObject = SharedObject.getLocal("MyFlashCookie");

			flashCookie.data.playername = data.getPlayerName();
			flashCookie.data.playerLastName = data.getPlayerLastName();
			flashCookie.data.id = data.getPlayerId();

			playerModel.setFlashCookie(flashCookie);
		}
	}
}
