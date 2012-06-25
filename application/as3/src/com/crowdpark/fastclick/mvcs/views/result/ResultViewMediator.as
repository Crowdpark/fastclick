package com.crowdpark.fastclick.mvcs.views.result
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class ResultViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			view.getDataProvider().setValueByKey('clickedBallAmount', String(playerModel.getCurrentPlayer().getValueByKey('clickedBallAmount')));

			var currentScore : ScoreVo = ScoreVo(playerModel.getCurrentPlayer().getValueByKey('currentScore'));
			view.getDataProvider().setValueByKey('currentScore', String(currentScore.getScore()));

			view.setResultText();
			view.disableRetry();

			addViewListener(ResultView.RETRY_GAME, onRetryGameListener);
			addContextListener(LeaderboardEvent.CREATE_HIGHEST_SCORES, onLeaderboardEvent);
			addContextListener(LeaderboardEvent.SHOW_HIGHEST_SCORE, onShowHighestScore);
		}

		private function onShowHighestScore(e : LeaderboardEvent) : void
		{
			var currentLevel : String = String(playerModel.getCurrentPlayer().getSelectedLevel());

			view.addToPane(highestScoreModel.getAllLevelsList()[String(currentLevel)]);
			view.enableRetry();
		}

		private function onLeaderboardEvent(e : LeaderboardEvent) : void
		{
			var result = e.getDataprovider().getValueByKey('result');
			var currentLevel : String = String(playerModel.getCurrentPlayer().getSelectedLevel());
			highestScoreModel.createHighestScoreLists(result);
			view.addToPane(highestScoreModel.getAllLevelsList()[String(currentLevel)]);
			view.enableRetry();
		}

		private function onRetryGameListener(event : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.REPLAY));
		}

		private function get view() : ResultView
		{
			return viewComponent as ResultView;
		}
	}
}
