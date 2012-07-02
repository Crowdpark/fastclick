package com.crowdpark.fastclick.mvcs.views.gift
{
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class GiftViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			addViewListener(GiftView.GIFT_SELECT, onGiftSelectListener);
		}

		private function onGiftSelectListener(event : Event) : void
		{
			var giftType : String = String(view.getDataProvider().getValueByKey('giftType'));
			giftModel.setCurrentGiftType(giftType);
			giftModel.createGift(playerModel.getCurrentPlayer().getPlayerId());

			dispatch(new GiftEvent(GiftEvent.SEND_GIFT));
		}

		private function get view() : GiftView
		{
			return viewComponent  as GiftView;
		}
	}
}
