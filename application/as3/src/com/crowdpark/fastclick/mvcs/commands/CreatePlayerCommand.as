package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class CreatePlayerCommand extends Command
	{
		[Inject]
		public var facebookServiceEvent : FacebookServiceEvent;
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var loadingModel : LoadingModel;
		[Inject]
		public var bitmapFetcherService : BitmapFetcherService;

		override public function execute() : void
		{
			loadingModel.setLoadingState('logged in');

			var params = facebookServiceEvent.getDataprovider().getValueByKey('params');
			if (params)
			{
				playerModel.createPlayer(String(params.first_name), String(params.last_name), String(params.id));
				bitmapFetcherService.fetchPlayerBitmap(String(params.id));
			}
		}
	}
}
