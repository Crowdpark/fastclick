package com.crowdpark.fastclick.mvcs.commands
{
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

		override public function execute() : void
		{
			var appFriends = backendServiceEvent.getDataprovider().getValueByKey('appFriends');
			var user = backendServiceEvent.getDataprovider().getValueByKey('user');

			playerModel.setCurrentLevel(user);
			playerModel.getCurrentPlayer().setAppFriendsList(appFriends);
		}
	}
}
