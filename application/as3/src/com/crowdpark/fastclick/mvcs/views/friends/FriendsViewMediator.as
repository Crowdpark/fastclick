package com.crowdpark.fastclick.mvcs.views.friends
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;

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
			addViewListener(FriendsView.SHOW_GIFTS, onShowGiftsListener);
			addContextListener(GameEvents.UPDATE_APP_FRIENDS_VIEW, onUpdateAppFriendsListener);
		}

		private function onShowGiftsListener(event : Event) : void
		{
			var recipientId : String = String(view.getDataProvider().getValueByKey('friendId'));
			giftModel.setRecipientId(recipientId);

			dispatch(new GiftEvent(GiftEvent.SHOW_GIFT_TYPES));
		}

		private function onUpdateAppFriendsListener(event : GameEvents) : void
		{
			view.getDataProvider().setValueByKey('appFriends', playerModel.getPlayerAppFriends());
			view.createAppFriends();
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
