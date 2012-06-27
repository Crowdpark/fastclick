package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

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

		override public function execute() : void
		{
			var score : uint = 10 + playerModel.getCurrentPlayer().getCurrentScore().getScore();

			playerModel.getCurrentPlayer().getCurrentScore().setScore(score);
			giftModel.getReceivedGiftList().pop();

			var receivedGift : String = String(giftEvent.getDataprovider().getValueByKey('receivedGift'));
			backendService.removeGift(receivedGift, playerModel.getCurrentPlayer());
		}
	}
}
