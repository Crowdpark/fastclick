package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

	import org.robotlegs.mvcs.Command;

	import flash.display.Bitmap;

	/**
	 * @author fatmatekin
	 */
	public class SetPlayerBitmapCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent;
		[Inject]
		public var bitmapFetcherService : BitmapFetcherService;

		override public function execute() : void
		{
			var bitmap : Bitmap = Bitmap(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('playerBitmap'));
			var currentPlayer : PlayerVo = playerModel.getCurrentPlayer();
			currentPlayer.setPlayerPicture(bitmap);

			playerModel.getPlayerAppFriends().push(currentPlayer);
			playerModel.sortLeaderBoard();
		}
	}
}
