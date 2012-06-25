package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SendGiftBackendCommand extends Command
	{
		[Inject]
		public var backendServiceEvent : BackendServiceEvents;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var giftModel : GiftModel;
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			var result = backendServiceEvent.getDataprovider().getValueByKey('result');
			giftModel.createBackendGifts(result);
			backendService.sendGift(playerModel.getCurrentPlayer().getPlayerId(), giftModel.getBackendGiftList());
		}
	}
}
