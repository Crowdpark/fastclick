package com.crowdpark.fastclick.mvcs.commands.gifts
{
	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;

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
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChild(mainSprite.getChildByName('giftView'));

			facebookService.sendGift(giftModel.getCurrentGift());
		}
	}
}
