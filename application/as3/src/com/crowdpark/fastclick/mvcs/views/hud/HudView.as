package com.crowdpark.fastclick.mvcs.views.hud
{
	import flash.display.Shape;

	import utils.draw.createRectangleShape;

	import flash.text.TextField;

	import utils.textField.createField;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class HudView extends Sprite
	{
		public var scoreTitle : TextField;
		public var score : TextField;
		public var timeSprite : Sprite;
		public var time : TextField;
		public var timeBarSprite : Sprite;
		public var playerNameField : TextField;
		public var playerNameSprite : Sprite;

		public function init() : void
		{
			createScoreView();
			createTimeView();
			createTimeBar();
			createPlayerName();
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
	}
}
