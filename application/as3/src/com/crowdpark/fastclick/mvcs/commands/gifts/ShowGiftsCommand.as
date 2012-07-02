package com.crowdpark.fastclick.mvcs.commands.gifts
{
	import com.crowdpark.fastclick.mvcs.models.GiftModel;

	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.views.gift.GiftView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ShowGiftsCommand extends Command
	{
		[Inject]
		public var giftModel : GiftModel;

		override public function execute() : void
		{
			var giftView : GiftView = new GiftView();
			giftView.getDataProvider().setValueByKey('giftVariety', giftModel.getGiftVariety());
			giftView.name = 'giftView';
			giftView.init();
			giftView.createGiftContainer();
			giftView.createGifts();

			giftView.y = 530;

			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.addChild(giftView);
		}
	}
}
