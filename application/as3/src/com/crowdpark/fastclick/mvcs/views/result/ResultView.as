package com.crowdpark.fastclick.mvcs.views.result
{
	import flash.events.MouseEvent;
	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class ResultView extends BaseView
	{
		public static const RETRY_GAME : String = "RETRY_GAME";
		public var resultText : TextField;
		public var result : TextField;
		public var retryButton : Sprite;
		public var leaderboardTitle : TextField;
		public var leaderboardResult : TextField;

		override public function  init() : void
		{
			resultText = createField("Your Score", 0, 0, 200, 20, false, "Verdana", 13);
			result = createField("", 0, 0, 200, 20, false, "Verdana", 22);

			leaderboardTitle = createField("Your Highest Score", 0, 0, 200, 20, false, "Verdana", 15);
			leaderboardResult = createField("", 0, 0, 200, 20, false, "Verdana", 20);

			addChild(result);
			addChild(resultText);
			addChild(leaderboardTitle);
			addChild(leaderboardResult);

			retryButton = new Sprite;
			retryButton.buttonMode = true;
			retryButton.addChild(createRectangleShape(80, 30, 0x00e0e6));

			var title : TextField = createField("RETRY", 0, 0, 200, 20, false, "Verdana", 20, 0xffffff);
			title.x = (retryButton.width - title.width) / 2;
			title.y = (retryButton.height - title.height) / 2;

			retryButton.addEventListener(MouseEvent.CLICK, onHandleRetryButton);

			retryButton.y = 300;
			retryButton.addChild(title);

			addChild(retryButton);
		}

		private function onHandleRetryButton(event : MouseEvent) : void
		{
			dispatchEvent(new Event(ResultView.RETRY_GAME));
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			resultText.x = (stage.stageWidth - resultText.textWidth) / 2;
			resultText.y = 50;

			result.x = (stage.stageWidth - result.textWidth) / 2;
			result.y = 70;

			leaderboardTitle.y = result.y + result.height + 40;
			leaderboardTitle.x = (stage.stageWidth - leaderboardTitle.width) / 2;

			leaderboardResult.y = leaderboardTitle.y + leaderboardTitle.height + 20;

			retryButton.x = (stage.stageWidth - retryButton.width) / 2;
		}

		public function setResultText() : void
		{
			result.text = this.getDataProvider().getValueByKey('clickedBallAmount') + ' clicks ' + this.getDataProvider().getValueByKey('currentScore') + ' points';
		}

		public function showHighestScore() : void
		{
			leaderboardResult.text = String(this.getDataProvider().getValueByKey('highestScore'));
			leaderboardResult.x = (stage.stageWidth - leaderboardResult.width) / 2;
		}
	}
}
