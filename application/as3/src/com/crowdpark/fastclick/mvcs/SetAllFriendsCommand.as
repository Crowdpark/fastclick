package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SetAllFriendsCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendServiceEvent : BackendServiceEvents

		override public function execute() : void
		{
			var allFriends = backendServiceEvent.getDataprovider().getValueByKey('allFriends');
			var user = backendServiceEvent.getDataprovider().getValueByKey('user');

			playerModel.setCurrentLevel(user);
			playerModel.setApplicationFriends(allFriends);
		}
	}
}
