package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BitmapLoaderServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BitmapLoaderService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class LoadBitmapCommand extends Command
	{
		[Inject]
		public var bitmapService : BitmapLoaderService;
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public	var bitmapServiceEvent : BitmapLoaderServiceEvent;

		override public function execute() : void
		{
			var friendIndex = bitmapServiceEvent.getDataprovider().getValueByKey('friendIndex');
			bitmapService.fetchBitMap(playerModel.getPlayerFriends()[friendIndex].getPlayerPictureUrl());
			
			
			
		}
	}
}
