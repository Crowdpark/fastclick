package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
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
		[Inject]
		public var loadingModel : LoadingModel;

		override public function execute() : void
		{
			var loadedFriends : Vector.<PlayerVo> = playerModel.getLoadedFriends();
			var friendsList : Object = playerModel.getCurrentPlayer().getFriendsList();
			var appFriendList : Object = playerModel.getCurrentPlayer().getAppFriendsList();

			var bitmap : Bitmap = Bitmap(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('bitmap'));
			playerModel.createFriendVo(bitmap, loadedFriends.length, playerModel.getCurrentList());

			if (loadedFriends.length == appFriendList.length)
			{
				contextView.removeChild(contextView.getChildByName('loading'));
				dispatch(new StateMachineEvents(StateMachineEvents.READY_TO_START));
				playerModel.startFetchingBitmaps(friendsList);
			}
		}
	}
}
