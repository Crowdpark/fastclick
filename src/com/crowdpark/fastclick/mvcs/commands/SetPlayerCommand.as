package com.crowdpark.fastclick.mvcs.commands
{
	import flash.net.SharedObject;

	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SetPlayerCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var gameEvents : GameEvents;
		

		override public function execute() : void
		{
			var flashCookie : SharedObject = SharedObject.getLocal("MyFlashCookie");
			flashCookie.data.playername = gameEvents.getDataprovider().getValueByKey('playerName');

			playerModel.setFlashCookie(flashCookie);

			var player : PlayerVo = new PlayerVo().setPlayerName(String(gameEvents.getDataprovider().getValueByKey('playerName')))
												.setCurrentScore(0);
			
			playerModel.addPlayer(player);
			playerModel.setCurrentPlayer(player);
			
		}
	}
}
