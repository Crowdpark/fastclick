package com.crowdpark.fastclick.mvcs.views.countrdown
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class CountDownViewMeditor extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.createCountdownNumbers();
			addViewListener(CountDownView.START_EVENT, onStartListener);
		}

		private function onStartListener(event : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.GAME));
		}

		public function get view() : CountDownView
		{
			return viewComponent as CountDownView;
		}
	}
}
