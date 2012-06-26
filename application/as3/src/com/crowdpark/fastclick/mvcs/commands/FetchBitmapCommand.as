package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchBitmapCommand extends Command
	{
		[Inject]
		public var bitmapService : BitmapFetcherService;
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent;

		override public function execute() : void
		{
			var url : String = String(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('url'));

			bitmapService.fetchBitMap(url);
		}
	}
}
