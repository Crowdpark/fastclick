package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StartFetchFriendsCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var backendServiceEvent : BackendServiceEvents;

		override public function execute() : void
		{
			playerModel.getCurrentPlayer().setFriendsList(backendServiceEvent.getDataprovider().getValueByKey('data'));
			backendService.storePlayer(playerModel.getCurrentPlayer());

			playerModel.createFriend(playerModel._currentFetchIndex);
		}
	}
}
