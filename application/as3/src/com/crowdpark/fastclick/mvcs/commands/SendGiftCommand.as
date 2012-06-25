package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SendGiftCommand extends Command
	{
		[Inject]
		public var facebookService : FacebookService;
		[Inject]
		public var giftModel : GiftModel;

		override public function execute() : void
		{
			facebookService.sendGift(giftModel.getCurrentGift());
		}
	}
}
