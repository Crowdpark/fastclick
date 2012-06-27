package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

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
		[Inject]
		public var bitmapFetcherService : BitmapFetcherService;

		override public function execute() : void
		{
			var loadedFriends : Vector.<PlayerVo> = playerModel.getLoadedFriends();

			var bitmap : Bitmap = Bitmap(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('bitmap'));
			playerModel.createFriendVo(bitmap, loadedFriends.length);
		}
	}
}
