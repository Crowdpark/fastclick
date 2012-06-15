package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;

	import org.robotlegs.mvcs.Command;

	import flash.display.Bitmap;

	/**
	 * @author fatmatekin
	 */
	public class BitmapFetchedCommand extends Command
	{
		[Inject]
		public var facebookService:FacebookService;
		
		[Inject]
		public var blsEvent:BitmapFetcherServiceEvent;
		
		[Inject]
		public var bitmapLoaderService:BitmapFetcherService;
				
		[Inject]
		public var playerModel:PlayerModel;		
		
		override public function execute() : void
		{
			
			/*var currentPlayer : PlayerVo = playerModel.getCurrentFetchPicturePlayer();
			currentPlayer.setPlayerPicture(Bitmap(bitmapServiceEvent.getDataprovider().getValueByKey('bitmap')));

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', currentPlayer);
			dispatch(gameEvent);*/
			
			
						
			facebookService.addLoadedBitmap(Bitmap(blsEvent.getDataprovider().getValueByKey('bitmap')));
		}
	}
}
