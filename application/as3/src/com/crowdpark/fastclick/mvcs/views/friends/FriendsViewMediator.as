package com.crowdpark.fastclick.mvcs.views.friends
{
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class FriendsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			addViewListener(FriendsView.INVITE_BUTTON_CLICKED, onInviteListener);
			addViewListener(FriendsView.SEND_GIFT_EVENT, onSendGiftListener);
			addContextListener(GameEvents.UPDATE_APP_FRIENDS_VIEW, onUpdateAppFriendsListener);

		}

	
		private function onUpdateAppFriendsListener(event : GameEvents) : void
		{
			view.getDataProvider().setValueByKey('appFriends', playerModel.getPlayerAppFriends());
			view.createAppFriends();
		}

		private function onSendGiftListener(event : Event) : void
		{
			var giftVo : GiftVo = new GiftVo();
			giftVo.setId(playerModel.getCurrentPlayer().getPlayerId());
			giftVo.setRecipientId(String(view.getDataProvider().getValueByKey('friendId')));
			giftVo.setGiftType(1);
			giftVo.setGiftAmount(10);
			giftVo.setMessage('Send gift Test');

			giftModel.setCurrentGift(giftVo);

			dispatch(new GiftEvent(GiftEvent.SEND_GIFT));
		}

		private function onInviteListener(event : Event) : void
		{
			dispatch(new FacebookServiceEvent(FacebookServiceEvent.INVITE_FRIEND));
		}

		private function get view() : FriendsView
		{
			return viewComponent as FriendsView;
		}
	}
}
