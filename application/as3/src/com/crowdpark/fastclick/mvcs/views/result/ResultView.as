package com.crowdpark.fastclick.mvcs.views.result
{
	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import com.bit101.components.ScrollPane;
	import com.bit101.components.VBox;
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author fatmatekin
	 */
	public class ResultView extends BaseView
	{
		public static const RETRY_GAME : String = "RETRY_GAME";
		public static const SHARE_BEAT : String = "SHARE_BEAT";
		public var resultText : TextField;
		public var result : TextField;
		public var retryButton : Sprite;
		public var leaderboardTitle : TextField;
		public var leaderboardResult : TextField;
		public var leaderboardPane : ScrollPane = new ScrollPane();
		public var vbox : VBox = new VBox();
		public var scoreArray : Vector.<ScoreVo> = new Vector.<ScoreVo>();
		private var beatSprite : Sprite = new Sprite();
		public var beatText : TextField;

		override public function  init() : void
		{
			resultText = createField("Your Score", 0, 0, 200, 20, false, "Verdana", 13);
			result = createField("", 0, 0, 200, 20, false, "Verdana", 22);

			leaderboardTitle = createField("Your Highest Score", 0, 0, 200, 20, false, "Verdana", 15);
			leaderboardResult = createField("", 0, 0, 200, 20, false, "Verdana", 20);

			leaderboardPane.color = 0xffffff;
			leaderboardPane.shadow = false;
			leaderboardPane.showGrid = false;
			leaderboardPane.autoHideScrollBar = true;
			leaderboardPane.addChild(vbox);
			vbox.spacing = 10;

			addChild(result);
			addChild(resultText);
			addChild(leaderboardTitle);
			addChild(leaderboardResult);
			addChild(leaderboardPane);

			beatSprite.visible = false;
			addChild(beatSprite);
			createBeatSprite();

			retryButton = new Sprite;

			retryButton.addChild(createRectangleShape(80, 30, 0x00e0e6));

			var title : TextField = createField("RETRY", 0, 0, 200, 20, false, "Verdana", 20, 0xffffff);
			title.x = (retryButton.width - title.width) / 2;
			title.y = (retryButton.height - title.height) / 2;

			retryButton.addChild(title);

			addChild(retryButton);
		}

		private function createBeatSprite() : void
		{
			var beatBackground : Shape = createRectangleShape(280, 70, 0xff0000);

			beatText = createField('', 0, 0, 200, 20, false, 'Verdana', 15, 0xffffff);
			beatText.y = 5;

			var buttonText : TextField = createField('Share', 0, 0, 200, 30, false, 'Verdana', 15, 0);
			buttonText.background = true;
			buttonText.backgroundColor = 0x7f007f;
			var buttonSprite : Sprite = new Sprite();
			buttonSprite.addChild(buttonText);
			buttonSprite.mouseChildren = false;
			buttonSprite.buttonMode = true;
			buttonSprite.addEventListener(MouseEvent.CLICK, onShareListener);

			buttonSprite.x = (beatBackground.width - buttonSprite.width) / 2;
			buttonSprite.y = beatBackground.height - buttonSprite.height - 10;

			beatSprite.addChild(beatBackground);
			beatSprite.addChild(beatText);
			beatSprite.addChild(buttonSprite);
		}

		private function onShareListener(event : MouseEvent) : void
		{
			dispatchEvent(new Event(ResultView.SHARE_BEAT));
		}

		public function enableRetry() : void
		{
			retryButton.mouseEnabled = true;
			retryButton.buttonMode = true;
			retryButton.addEventListener(MouseEvent.CLICK, onHandleRetryButton);
		}

		public function disableRetry() : void
		{
			retryButton.mouseEnabled = false;
			retryButton.buttonMode = false;
			retryButton.removeEventListener(MouseEvent.CLICK, onHandleRetryButton);
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

			leaderboardResult.x = (stage.stageWidth - leaderboardResult.width) / 2;
			leaderboardResult.y = leaderboardTitle.y + leaderboardTitle.height + 20;
			leaderboardPane.y = leaderboardResult.y + 50;

			retryButton.x = (stage.stageWidth - retryButton.width) / 2;
			retryButton.y = 400;

			leaderboardPane.setSize(280, 150);
			leaderboardPane.x = (stage.stageWidth - leaderboardPane.width) / 2;

			beatSprite.x = (stage.stageWidth - beatSprite.width) / 2;
			beatSprite.y = leaderboardPane.y + leaderboardPane.height + 80;
		}

		public function setResultText() : void
		{
			result.text = this.getDataProvider().getValueByKey('clickedBallAmount') + ' clicks ' + this.getDataProvider().getValueByKey('currentScore') + ' points';
		}

		public function addToPane(scoreArray : Vector.<ScoreVo>) : void
		{
			for (var i : uint = 0;i < scoreArray.length;i++)
			{
				var scoreVo : ScoreVo = (scoreArray[i]);
				var currDate : Date = new Date();

				if (scoreVo.getDate() != 0)
				{
					currDate = new Date(Number(scoreVo.getDate()) * 1000);
				}
				var _date : String = currDate.getDate() + '-' + (currDate.getMonth() + 1) + '-' + currDate.getFullYear();

				vbox.addChild(createField('Score=' + scoreVo.getScore() + '        ' + 'Date=' + _date, 10, 10, 200, 20, false, 'Verdana', 15, 0x000000));
				leaderboardPane.update();
			}
		}

		public function showBeatFriend() : void
		{
			var beatFriend : PlayerVo = PlayerVo(this.getDataProvider().getValueByKey('beatFriend'));

			beatSprite.visible = true;
			beatText.text = 'Congrats! You beat ' + beatFriend.getPlayerFullName();
			beatText.x = (beatSprite.width - beatText.width) / 2;
		}

		public function hideBeatFriend() : void
		{
			beatSprite.visible = false;
		}
	}
}
