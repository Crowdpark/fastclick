package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
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
		public var backendServiceEvent : BackendServiceEvents;
		[Inject]
		public var giftModel :GiftModel;
		
		override public function execute() : void
		{
			var data = backendServiceEvent.getDataprovider().getValueByKey('data');

			playerModel.setCurrentLevel(data.user);
			playerModel.getCurrentPlayer().setAppFriendsList(data.allFriends);
			
			giftModel.createReceivedGifts(data.gifts);
			playerModel.getCurrentPlayer().setReceivedGifts(giftModel.getReceivedGiftList());
		}
	}
}
