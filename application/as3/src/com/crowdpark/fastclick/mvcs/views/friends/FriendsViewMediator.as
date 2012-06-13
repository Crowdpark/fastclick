package com.crowdpark.fastclick.mvcs.views.friends
{
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class FriendsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			addViewListener(FriendsView.INVITE_BUTTON_CLICKED, onInviteListener);
			addContextListener(GameEvents.SHOW_FRIEND, onShowFriendListener);
		}
		private function onInviteListener(event : Event) : void
		{
			dispatch(new FacebookServiceEvent(FacebookServiceEvent.INVITE_FRIEND));
		}

		private function onShowFriendListener(event : GameEvents) : void
		{
			view.getDataProvider().setValueByKey('currentFriend', event.getDataprovider().getValueByKey('currentFriend'));
			view.createFriend();
		}

		private function get view() : FriendsView
		{
			return viewComponent as FriendsView;
		}
	}
}
