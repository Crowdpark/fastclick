package com.crowdpark.fastclick.mvcs.views.control
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class ControlViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			addViewListener(ControlView.INVITE_FRIENDS, onInviteFriendsListener);
			addViewListener(ControlView.SEND_GIFTS, onSendGiftsListener);
			addViewListener(ControlView.PLAY, onPlayListener);
		}

		private function onPlayListener(event : Event) : void
		{
			dispatch(new ControlViewEvent(ControlViewEvent.PLAY));
		}

		private function onSendGiftsListener(event : Event) : void
		{
			dispatch(new ControlViewEvent(ControlViewEvent.SEND_GIFTS));
		}

		private function onInviteFriendsListener(event : Event) : void
		{
			dispatch(new ControlViewEvent(ControlViewEvent.INVITE_FRIENDS));
		}
	}
}