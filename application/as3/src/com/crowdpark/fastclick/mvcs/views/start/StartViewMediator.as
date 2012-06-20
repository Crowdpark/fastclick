package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.y = 50;

			if (playerModel.getCurrentPlayer().getPlayerName() != "null")
			{
				view.updatePlayerNameField(playerModel.getCurrentPlayer().getPlayerName(), playerModel.getCurrentPlayer().getPlayerLastName());
			}
			if (stateMachineModel.state == StateMachineState.REPLAY)
			{
				view.removeLoading();
			}

			addViewListener(StartView.START_GAME, onStartGameListener);
			addContextListener(GameEvents.SET_PLAYER_COOKIE, setPlayerListener);
		}

		override public function handleReadyToStart(e : StateMachineEvents) : void
		{
			super.handleReadyToStart(e);
			view.removeLoading();
		}

		private function setPlayerListener(event : GameEvents) : void
		{
			view.updatePlayerNameField(String(event.getDataprovider().getValueByKey('playerName')), String(event.getDataprovider().getValueByKey('playerLastName')));
		}

		private function onStartGameListener(e : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		protected function get view() : StartView
		{
			return viewComponent as StartView;
		}

		override protected function handleStart(e : StateMachineEvents) : void
		{
			super.handleStart(e);
		}
	}
}
