package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ShowAppFriendsCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var serviceEvent : BitmapFetcherServiceEvent;
		[Inject]
		public var bitmapFetcherService : BitmapFetcherService;

		override public function execute() : void
		{
			var arr : Array = (serviceEvent.getDataprovider().getValueByKey('array') as Array);
			playerModel.createAppFriendVos(arr);

			bitmapFetcherService.startFetchingBitmaps(playerModel.getCurrentPlayer().getFriendsList());
		}
	}
}