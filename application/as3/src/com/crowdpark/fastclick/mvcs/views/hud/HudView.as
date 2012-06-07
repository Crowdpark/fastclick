package com.crowdpark.fastclick.mvcs.views.hud
{
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
			createPlayerName();
			
			
		}
		override public function onAddedToStageListener(e : Event) : void
		{
			var hudViewBackground : Shape = createRectangleShape(stage.stageWidth, 60, 0x000000);
			addChildAt(hudViewBackground,0);
			
			var timeBar : Shape = createRectangleShape(10, stage.stageHeight - 120, 0, 10, stage.stageWidth - 10, this.height);
			var barMask : Shape = createRectangleShape(10, stage.stageHeight - 120, 0, 10, stage.stageWidth - 10, this.height);
			timeBar.mask = barMask;

			TweenMax.to(barMask, uint(this.getDataProvider().getValueByKey('gameDuration')), {y:stage.stageHeight - 60, ease:Linear.easeNone});

			addChild(timeBar);
			addChild(barMask);
			
		
			scoreTitle.y = 20;
			scoreTitle.x = 5;
			score.x = 5;
			timeSprite.x = stage.stageWidth - timeSprite.width - 20;
			playerNameSprite.x = timeSprite.x - 70;

			playerNameField.text = String(this.getDataProvider().getValueByKey('playerName'));

			playerNameSprite.getChildAt(0).width = playerNameField.width + 6;
			playerNameSprite.getChildAt(0).height = playerNameField.height + 6;
			
			playerNameField.x = (playerNameSprite.width - playerNameField.width) / 2;
			playerNameField.y = (playerNameSprite.height - playerNameField.height) / 2;

			time.text = String(this.getDataProvider().getValueByKey('gameDuration'));
			timeSprite.x = stage.stageWidth - timeSprite.width - 20;
			playerNameSprite.x = timeSprite.x - 70;
		}

		private function createPlayerName() : void
		{
			var playerNameBackground : Shape = createRectangleShape(100, 30, 0xcacaca);
			playerNameField = createField("", 0, 0, 100, 20, false, "Verdana", 12, 0xffffff);
			playerNameSprite = new Sprite();

			playerNameSprite.addChild(playerNameBackground);
			playerNameSprite.addChild(playerNameField);

			addChild(playerNameSprite);
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
			timeSprite.x = stage.stageWidth - timeSprite.width - 20;
			playerNameSprite.x = timeSprite.x - 70;
		}
	}
}
