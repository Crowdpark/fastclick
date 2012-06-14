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
			view.result.text = (String(playerModel.getCurrentPlayer().getValueByKey('clickedBallAmount'))) + ' clicks ' + (String(playerModel.getCurrentPlayer().getValueByKey('currentScore'))) + ' points';
			view.resultText.x = (contextView.stage.stageWidth - view.resultText.textWidth) / 2;
			view.resultText.y = 50;

			view.result.x = (contextView.stage.stageWidth - view.result.textWidth) / 2;
			view.result.y = 70;

			view.leaderboardTitle.y = view.result.y + view.result.height + 40;
			view.leaderboardTitle.x = (contextView.stage.stageWidth - view.leaderboardTitle.width) / 2;

			view.retryButton.x = (contextView.stage.stageWidth - view.retryButton.width) / 2;

			view.retryButton.addEventListener(MouseEvent.CLICK, handleRetryButton);
			
			addContextListener(LeaderboardEvent.SHOW_HIGHEST_SCORE, onLeaderboardEvent)
		}

		private function onLeaderboardEvent(e:Event) : void
		{
			
		}

		private function handleRetryButton(event : MouseEvent) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.RETRY));
		}

		private function get view() : ResultView
		{
			return viewComponent as ResultView;
		}
	}
}
