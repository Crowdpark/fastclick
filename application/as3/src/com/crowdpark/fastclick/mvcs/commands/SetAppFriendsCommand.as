package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SetAppFriendsCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendServiceEvent : BackendServiceEvent;
		[Inject]
		public var giftModel : GiftModel;
		[Inject]
		public var loadingModel : LoadingModel;
		[Inject]
		public var bitmapFetcherService : BitmapFetcherService;

		override public function execute() : void
		{
			loadingModel.setLoadingState('fetching friends');

			var data : Object = backendServiceEvent.getDataprovider().getValueByKey('data');
			var currentPlayer : PlayerVo = playerModel.getCurrentPlayer();

			currentPlayer.setCurrentLevel(data.user.level);
			currentPlayer.setAppFriendsList(data.appFriends);
			currentPlayer.setHighestScore(new ScoreVo().setScore(data.user.high_score));
			bitmapFetcherService.fetchPlayerBitmap(currentPlayer.getPlayerId());

			giftModel.createReceivedGifts(data.gifts);
			currentPlayer.setReceivedGifts(giftModel.getReceivedGiftList());

			if (currentPlayer.getAppFriendsList().length > 0)
			{
				bitmapFetcherService.fetchAppBitmaps(currentPlayer.getAppFriendsList());
			}
			else
			{
				bitmapFetcherService.startFetchingBitmaps(currentPlayer.getFriendsList());
			}
		}
	}
}
