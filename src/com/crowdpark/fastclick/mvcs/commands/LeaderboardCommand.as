package com.crowdpark.fastclick.mvcs.commands
{
	import flash.net.SharedObject;

	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var leaderboardEvent : LeaderboardEvent;

		override public function execute() : void
		{
			playerModel.setPlayerName(leaderboardEvent.playerName);

			var flashCookie : SharedObject = SharedObject.getLocal("MyFlashCookie");
			flashCookie.data.playername = leaderboardEvent.playerName;
			playerModel.setFlashCookie(flashCookie);
		}
	}
}
