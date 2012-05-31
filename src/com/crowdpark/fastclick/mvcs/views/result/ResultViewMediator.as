package com.crowdpark.fastclick.mvcs.views.result
{
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
			view.result.text = (String(playerModel.getCurrentPlayer().getValueByKey('currentScore')));
			view.resultText.x = (contextView.stage.stageWidth - view.resultText.textWidth) / 2;
			view.resultText.y = 50;

			view.result.x = (contextView.stage.stageWidth - view.result.textWidth) / 2;
			view.result.y = 80;
			
			view.leaderboardTitle.y =view.result.y + view.result.height+40;
			view.leaderboardTitle.x =(contextView.stage.stageWidth - view.leaderboardTitle.width) / 2;
			
			view.leaderboardView.y = view.leaderboardTitle.y + 30;
			view.leaderboardView.x = (contextView.stage.stageWidth - view.leaderboardView.width) / 2;

			view.retryButton.x = (contextView.stage.stageWidth - view.retryButton.width) / 2;
			view.retryButton.y = view.leaderboardView.height + view.leaderboardView.y + 100;

			view.retryButton.addEventListener(MouseEvent.CLICK, handleRetryButton);
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
