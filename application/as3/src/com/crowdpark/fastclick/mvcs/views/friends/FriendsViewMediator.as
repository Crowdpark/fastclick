package com.crowdpark.fastclick.mvcs.views.friends
{
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
			addContextListener(GameEvents.SHOW_FRIEND, onShowFriendListener);
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
