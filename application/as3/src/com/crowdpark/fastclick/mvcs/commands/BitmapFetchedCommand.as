package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
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

			var gameEvent : GameEvents = new GameEvents(GameEvents.CREATE_APP_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', currentFriend);
			dispatch(gameEvent);

			if (playerModel.getCurrentFetchIndex() < playerModel.getFacebookFriendsList().length)
			{
				playerModel.createFriend(playerModel.getCurrentFetchIndex());
				playerModel.setCurrentFetchIndex(playerModel.getCurrentFetchIndex() + 1);
			}
			else
			{
				dispatch(new StateMachineEvents(StateMachineEvents.READY_TO_PLAY));
			}
		}
	}
}
