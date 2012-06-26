package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

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

		override public function execute() : void
		{
			loadingModel.setLoadingState('fetching friends');

			var data = backendServiceEvent.getDataprovider().getValueByKey('data');

			playerModel.setCurrentLevel(data.user.level);
			playerModel.getCurrentPlayer().setAppFriendsList(data.appFriends);
			//playerModel.addAppFriends(data.appFriends);

			giftModel.createReceivedGifts(data.gifts);
			playerModel.getCurrentPlayer().setReceivedGifts(giftModel.getReceivedGiftList());

			//playerModel.startFetchingBitmaps();
			playerModel.startFetchingBitmaps(playerModel.getCurrentPlayer().getFriendsList());
		}
	}
}
