package com.crowdpark.fastclick.mvcs.views.gift
{
	import flash.events.MouseEvent;

	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.Sprite;

	import utils.draw.createRectangleShape;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class GiftView extends BaseView
	{
		public static const GIFT_SELECT : String = "GIFT_SELECT";
		private var gift_container : Sprite = new Sprite();
		private var background : Shape;

		override public function init() : void
		{
			addChild(gift_container);
		}

		public function createGifts() : void
		{
			var xpos : uint = 0;
			var giftVariety : Object = getDataProvider().getValueByKey('giftVariety');

			for (var key:String in giftVariety)
			{
				var singleGiftView : SingleGiftView = new SingleGiftView();
				singleGiftView.init();
				singleGiftView.setGiftType(String(key));

				var title : String = giftVariety[key].amount + ' ' + giftVariety[key].type;
				singleGiftView.setGiftTitleText(title);
				singleGiftView.setBackgroundColor(0xff0000);
				singleGiftView.x = xpos;
				singleGiftView.buttonMode = true;
				singleGiftView.mouseChildren = false;
				singleGiftView.addEventListener(MouseEvent.CLICK, onGiftClick);
				xpos += singleGiftView.width + 10;
				gift_container.addChild(singleGiftView);
			}

			addChild(gift_container);
		}

		private function onGiftClick(event : MouseEvent) : void
		{
			getDataProvider().setValueByKey('giftType', SingleGiftView(event.currentTarget).getGiftType());
			dispatchEvent(new Event(GiftView.GIFT_SELECT));
		}

		public function createGiftContainer() : void
		{
			background = createRectangleShape(200, 100, 0x000000, 1);
			addChild(background);

			var title : TextField = createField('Choose a gift to send your friends', 0, 0, 200, 20, false, 'Verdana', 10, 0xffffff);
			title.x = (background.width - title.width) / 2;
			title.y = 10;

			addChild(title);
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			gift_container.x = (background.width - gift_container.width) / 2;
			gift_container.y = background.height - gift_container.height - 10;
		}
	}
}
