package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.events.RetryGameEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class ResultViewMediator extends Mediator
	{
		[Inject]
		public var playerModel : PlayerModel;

		override public function onRegister() : void
		{
			view.result.text = (String(playerModel.score));
			view.resultText.x = (contextView.stage.stageWidth-view.resultText.textWidth)/2;
			view.resultText.y =50;
			
			view.result.x = (contextView.stage.stageWidth-view.result.textWidth)/2;
			view.result.y =100;
			
			view.retryButton.x = (contextView.stage.stageWidth-view.retryButton.width)/2;			
			view.retryButton.y = 200;
			view.retryButton.addEventListener(MouseEvent.CLICK, handleRetryButton);
		}

		private function handleRetryButton(event:MouseEvent) : void
		{
			dispatch(new RetryGameEvent(RetryGameEvent.RETRY_GAME));
		}

		private function get view() : ResultView
		{
			return viewComponent as ResultView;
		}
	}
}
