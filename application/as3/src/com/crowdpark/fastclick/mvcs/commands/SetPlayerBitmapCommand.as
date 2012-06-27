package com.crowdpark.fastclick.mvcs.commands
{
	import flash.display.Bitmap;

	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SetPlayerBitmapCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent;

		override public function execute() : void
		{
			var bitmap : Bitmap = Bitmap(bitmapFetcherServiceEvent.getDataprovider().getValueByKey('playerBitmap'));

			playerModel.getCurrentPlayer().setPlayerPicture(bitmap);
		}
	}
}
