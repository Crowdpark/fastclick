package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.y = 50;
			
			view.updatePlayerNameField();
			
			addViewListener(StartView.START_GAME, onStartGameListener);
		}

		private function onStartGameListener(e : Event) : void
		{
			trace('onstartgame');
			view.updatePlayerNameField();
			
			dispatch(new StateMachineEvents(StateMachineEvents.START));
			
			dispatch(new GameEvents(GameEvents.SET_PLAYER).setDataprovider(view.getDataProvider()));
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
