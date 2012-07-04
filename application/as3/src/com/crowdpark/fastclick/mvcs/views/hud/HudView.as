package com.crowdpark.fastclick.mvcs.views.hud
{
	import flash.display.DisplayObject;

	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;

	import flash.events.MouseEvent;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.events.Event;
	import flash.display.Shape;

	import utils.draw.createRectangleShape;

	import flash.text.TextField;

	import utils.textField.createField;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class HudView extends BaseView
	{
		private static const LOGOUT : String = "LOGOUT";
		public var scoreTitle : TextField = new TextField();
		public var score : TextField = new TextField();
		public var level : TextField = new TextField();
		public var exp : TextField = new TextField();
		public var timeSprite : Sprite = new Sprite();
		public var time : TextField = new TextField();
		public var timeBarSprite : Sprite = new Sprite();
		public var playerNameField : TextField = new TextField();
		public var playerNameSprite : Sprite = new Sprite();

		override public function init() : void
		{
			createScoreView();
			createTimeView();
			createTimeBar();
			createLevel();
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			var timeBar : Shape = createRectangleShape(10, stage.stageHeight - 265, 0, 10, stage.stageWidth - 10, 60);
			var barMask : Shape = createRectangleShape(10, stage.stageHeight - 265, 0, 10, stage.stageWidth - 10, 60);
			timeBar.mask = barMask;

			TweenMax.to(barMask, uint(this.getDataProvider().getValueByKey('gameDuration')), {y:stage.stageHeight - 265, ease:Linear.easeNone});

			scoreTitle.y = 20;
			scoreTitle.x = 5;
			score.x = 5;
			timeSprite.x = stage.stageWidth - timeSprite.width - 20;

			var playerName : String = String(this.getDataProvider().getValueByKey('playerName'));
			var playerLastName : String = String(this.getDataProvider().getValueByKey('playerLastName'));

			playerNameField = createField("", 0, 0, 100, 20, false, "Verdana", 12, 0xffffff);
			playerNameField.text = playerName + ' ' + playerLastName;
			playerNameField.background = true;
			playerNameField.backgroundColor = 0xcacaca;
			playerNameField.x = stage.stageWidth - playerNameField.width;

			level.x = stage.stageWidth - level.width;
			level.y = playerNameField.height;

			exp.y = level.y + level.height;

			time.text = String(this.getDataProvider().getValueByKey('gameDuration'));
			timeSprite.x = (stage.stageWidth - timeSprite.width) / 2;

			var logoutSprite : Sprite = createButtonWithTitle('Logout');
			logoutSprite.addEventListener(MouseEvent.CLICK, onLogoutListener);
			logoutSprite.x = stage.stageWidth - 50;
			logoutSprite.y = 60 - logoutSprite.height;

			addChild(timeBar);
			addChild(barMask);
			addChild(playerNameField);
		}

		private function onLogoutListener(e : MouseEvent) : void
		{
			dispatchEvent(new Event(HudView.LOGOUT));
		}

		private function createButtonWithTitle(title : String) : Sprite
		{
			var buttonTitle : TextField = createField(title, 0, 0, 100, 20, false, "Verdana", 12, 0xffffff);
			buttonTitle.background = true;
			buttonTitle.backgroundColor = 0xcacaca;
			buttonTitle.name = 'buttonTitle';

			var buttonSprite : Sprite = new Sprite();
			buttonSprite.addChild(buttonTitle);
			buttonSprite.mouseChildren = false;
			buttonSprite.buttonMode = true;

			return buttonSprite;
		}

		private function createTimeBar() : void
		{
			timeBarSprite = new Sprite();
		}

		private function createTimeView() : void
		{
			timeSprite = new Sprite();

			time = createField("", 0, 0, 200, 20, false, "Verdana", 25, 0x000000);

			timeSprite.addChild(time);
			addChild(timeSprite);
		}

		private function createScoreView() : void
		{
			scoreTitle = createField("score", 0, 0, 200, 20, false, "Verdana", 15, 0x000000);
			addChild(scoreTitle);

			score = createField("0", 0, 0, 200, 20, false, "Verdana", 20, 0x000000);
			addChild(score);
		}

		private function createLevel() : void
		{
			level = createField("0", 0, 0, 200, 20, false, "Verdana", 20, 0x000000);
			level.background = true;
			level.backgroundColor = 0xcacaca;
			addChild(level);

			exp = createField("", 0, 0, 200, 20, false, "Verdana", 12, 0x000000);
			exp.background = true;
			exp.backgroundColor = 0x00ff00;
			exp.visible = false;
			addChild(exp);
		}

		public function updateTime(timeText : int) : void
		{
			getDataProvider().setValueByKey('time', timeText);
			time.text = String(timeText);
		}

		public function updateLevel(currentLevel : uint, neededScore : uint, upperLevel : uint) : void
		{
			level.text = 'LEVEL ' + String(currentLevel);
			level.x = stage.stageWidth - level.width;

			if (neededScore && upperLevel)
			{
				exp.text = neededScore + ' needed for level ' + upperLevel;
				exp.x = stage.stageWidth - exp.width;
				exp.visible = true;
			}
		}

		public function updateScore(scoreText : String) : void
		{
			score.text = scoreText;
		}

		public function addScoreBox(scoreBox : BaseGraphic) : void
		{
			addChild(scoreBox);

			TweenMax.to(scoreBox, 0.3, {alpha:1, x:scoreBox.getEndPoint().x, y:scoreBox.getEndPoint().y, onComplete:handleTweenComplete, onCompleteParams:[scoreBox]});
		}

		private function handleTweenComplete(scoreBox : InterfaceCircle) : void
		{
			removeChild(DisplayObject(scoreBox));
		}
	}
}
