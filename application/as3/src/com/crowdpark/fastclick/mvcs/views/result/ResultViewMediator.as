package com.crowdpark.fastclick.mvcs.views.result
{
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	import flash.events.MouseEvent;

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

			addViewListener(ResultView.RETRY_GAME, onRetryGameListener);
			addContextListener(LeaderboardEvent.SHOW_HIGHEST_SCORE, onLeaderboardEvent);
		}

		private function onLeaderboardEvent(e : LeaderboardEvent) : void
		{
			view.getDataProvider().setValueByKey('highestScore', e.getDataprovider().getValueByKey('result'));
			view.showHighestScore();
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
