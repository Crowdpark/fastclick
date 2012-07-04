package com.crowdpark.fastclick.mvcs.commands.gifts
{
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class AddGiftCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var giftModel : GiftModel;
		[Inject]
		public var giftEvent : GiftEvent;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var configModel : ConfigModel;

		override public function execute() : void
		{
			var receivedGift : String = String(giftEvent.getDataprovider().getValueByKey('receivedGift'));
			var type : String = String(giftEvent.getDataprovider().getValueByKey('giftType'));

			var giftType : Object = giftModel.getGiftVariety()[type];

			if (giftType.type == 'seconds')
			{
				configModel.setGameDuration(configModel.getGameDuration() + uint(giftType.amount));
			}
			else
			{
				var score : uint = 10 + playerModel.getCurrentPlayer().getCurrentScore().getScore();
				playerModel.getCurrentPlayer().getCurrentScore().setScore(score);
			}

			giftModel.getReceivedGiftList().pop();
			backendService.removeGift(receivedGift, playerModel.getCurrentPlayer());
		}
	}
}
