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
		public	var bitmapServiceEvent : BitmapFetcherServiceEvent;

		override public function execute() : void
		{
			var friendIndex : uint = uint(bitmapServiceEvent.getDataprovider().getValueByKey('friendIndex'));
			 bitmapService.fetchBitMap(playerModel.getPlayerFriends()[friendIndex].getPlayerPictureUrl());

			//var currentPlayer : PlayerVo = PlayerVo(bitmapServiceEvent.getDataprovider().getValueByKey('currentPlayer'));
			//playerModel.setCurrentFetchPicturePlayer(currentPlayer);
			
			//bitmapService.fetchBitMap(currentPlayer.getPlayerPictureUrl());
		}
	}
}
