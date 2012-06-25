package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Command;

	import flash.display.Bitmap;

	/**
	 * @author fatmatekin
	 */
	public class BitmapFetchedCommand extends Command
	{
		[Inject]
		public var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent;
		[Inject]
		public var playerModel : PlayerModel;
		
		override public function execute() : void
		{
			var playerFriendsVector : Vector.<PlayerVo> = playerModel.getPlayerFriends();
			var currentFriend : PlayerVo = playerFriendsVector[playerFriendsVector.length - 1];

			currentFriend.setPlayerPicture(Bitmap(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('bitmap')));

			var currentFetchIndex : uint = currentFriend.getFetchIndex();
			var friendList = playerModel.getCurrentPlayer().getFriendsList();

			if ( currentFetchIndex < friendList.length - 1)
			{
				currentFriend.setFetchIndex(currentFetchIndex + 1);
				playerModel.createFriend(currentFriend.getFetchIndex());
			}
			else
			{
				playerModel.filterAppFriends();
				dispatch(new StateMachineEvents(StateMachineEvents.READY_TO_START));
			}
		}
	}
}
