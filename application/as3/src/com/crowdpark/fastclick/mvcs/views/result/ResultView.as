package com.crowdpark.fastclick.mvcs.views.result
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.views.leaderboard.LeaderboardView;

	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class ResultView extends BaseView
	{
		public var resultText : TextField;
		public var result : TextField;
		public var retryButton : Sprite;
		public var leaderboardView : LeaderboardView;
		public var leaderboardTitle : TextField;

		override public function  init() : void
		{
			resultText = createField("Your Score", 0, 0, 200, 20, false, "Verdana", 13);
			result = createField("", 0, 0, 200, 20, false, "Verdana", 22);
			leaderboardTitle = createField("HIGHEST SCORES", 0, 0, 200, 20, false, "Verdana", 15);

			addChild(result);
			addChild(resultText);
			addChild(leaderboardTitle);

			retryButton = new Sprite;
			retryButton.addChild(createRectangleShape(80, 30, 0x00e0e6));

			var title : TextField = createField("RETRY", 0, 0, 200, 20, false, "Verdana", 15, 0xffffff);
			title.x = (retryButton.width - title.width) / 2;
			title.y = (retryButton.height - title.height) / 2;

			retryButton.addChild(title);

			addChild(retryButton);

			leaderboardView = new LeaderboardView();
			leaderboardView.init();
			addChild(leaderboardView);
		}
	}
}
