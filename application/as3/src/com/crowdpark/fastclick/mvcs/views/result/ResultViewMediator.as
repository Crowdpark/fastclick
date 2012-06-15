package com.crowdpark.fastclick.mvcs.views.result
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class ResultViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			view.getDataProvider().setValueByKey('clickedBallAmount', String(playerModel.getCurrentPlayer().getValueByKey('clickedBallAmount')));
			view.getDataProvider().setValueByKey('currentScore', String(playerModel.getCurrentPlayer().getValueByKey('currentScore')));
			view.setResultText();
			view.disableRetry();

			addViewListener(ResultView.RETRY_GAME, onRetryGameListener);
			addContextListener(LeaderboardEvent.SHOW_HIGHEST_SCORE, onLeaderboardEvent);
		}

		private function onLeaderboardEvent(e : LeaderboardEvent) : void
		{
			view.getDataProvider().setValueByKey('highestScore', e.getDataprovider().getValueByKey('result'));
			view.showHighestScore();
			view.enableRetry();
		}

		private function onRetryGameListener(event : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.RETRY));
		}

		private function get view() : ResultView
		{
			return viewComponent as ResultView;
		}
	}
}
