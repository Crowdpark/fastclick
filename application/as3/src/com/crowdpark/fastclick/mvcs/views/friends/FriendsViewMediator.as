package com.crowdpark.fastclick.mvcs.views.friends
{
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
			addContextListener(GameEvents.CREATE_APP_FRIEND, onCreateAppFriendListener);
		}

		private function onInviteListener(event : Event) : void
		{
			dispatch(new FacebookServiceEvent(FacebookServiceEvent.INVITE_FRIEND));
		}

		private function onCreateAppFriendListener(event : GameEvents) : void
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
