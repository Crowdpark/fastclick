package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import flash.events.MouseEvent;

	/**
	 * @author fatmatekin
	 */
	public class ResultViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			view.result.text = (String(playerModel.score));
			view.resultText.x = (contextView.stage.stageWidth-view.resultText.textWidth)/2;
			view.resultText.y =50;
			
			view.result.x = (contextView.stage.stageWidth-view.result.textWidth)/2;
			view.result.y =100;
			
			view.retryButton.x = (contextView.stage.stageWidth-view.retryButton.width)/2;			
			view.retryButton.y = 200;
			eventMap.mapListener(view.retryButton, "click", handleRetryButton);
		}

		private function handleRetryButton(event:MouseEvent) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.RETRY));
		}

		private function get view() : ResultView
		{
			return viewComponent as ResultView;
		}
	}
}
