package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StoreGetAppFriendsCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var backendServiceEvent : BackendServiceEvent;

		override public function execute() : void
		{
			playerModel.getCurrentPlayer().setFriendsList(backendServiceEvent.getDataprovider().getValueByKey('data'));

			backendService.storePlayerGetAppFriend(playerModel.getCurrentPlayer());
		}
	}
}