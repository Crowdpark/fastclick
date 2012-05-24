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
		public var timeTitle : TextField;
		public var time : TextField;

		public function HudView()
		{
			init();
		}

		private function init() : void
		{
			createScoreView();
			createTimeView();
		}

		private function createTimeView() : void
		{
			timeTitle = createField("Time:", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(timeTitle);

			time = createField("", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(time);
		}

		private function createScoreView() : void
		{
			scoreTitle = createField("Score:", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(scoreTitle);

			score = createField("0", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(score);
		}
	}
}
