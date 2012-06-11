package com.crowdpark.fastclick.mvcs.views.hud
{
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
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			var hudViewBackground : Shape = createRectangleShape(stage.stageWidth, 60, 0x000000);

			var timeBar : Shape = createRectangleShape(10, stage.stageHeight - 200, 0, 10, stage.stageWidth - 10, hudViewBackground.height);
			var barMask : Shape = createRectangleShape(10, stage.stageHeight - 200, 0, 10, stage.stageWidth - 10, hudViewBackground.height);
			timeBar.mask = barMask;

			TweenMax.to(barMask, uint(this.getDataProvider().getValueByKey('gameDuration')), {y:stage.stageHeight - 140, ease:Linear.easeNone});

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

			time.text = String(this.getDataProvider().getValueByKey('gameDuration'));
			timeSprite.x = (stage.stageWidth - timeSprite.width) / 2;

			var logoutSprite : Sprite = createButtonWithTitle('Logout');
			logoutSprite.addEventListener(MouseEvent.CLICK, onLogoutListener);
			logoutSprite.x = stage.stageWidth - 50;
			logoutSprite.y = 60 - logoutSprite.height;

			addChildAt(hudViewBackground, 0);
			addChild(timeBar);
			addChild(barMask);
			// addChild(logoutSprite);
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

			time = createField("", 0, 0, 200, 20, false, "Verdana", 25, 0xffffff);

			timeSprite.addChild(time);
			addChild(timeSprite);
		}

		private function createScoreView() : void
		{
			scoreTitle = createField("score", 0, 0, 200, 20, false, "Verdana", 15, 0xffffff);
			addChild(scoreTitle);

			score = createField("0", 0, 0, 200, 20, false, "Verdana", 20, 0xffffff);
			addChild(score);
		}

		public function updateTime() : void
		{
			time.text = String(this.getDataProvider().getValueByKey('time'));
		}
	}
}
