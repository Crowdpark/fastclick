package com.crowdpark.fastclick.mvcs.views.hud
{
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

		public function HudView()
		{
		}

		public function init() : void
		{
			createScoreView();
			createTimeView();
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
			scoreTitle = createField("score", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(scoreTitle);

			score = createField("0", 0, 0, 200, 20, false, "Verdana", 20, 0);
			addChild(score);
		}
	}
}
