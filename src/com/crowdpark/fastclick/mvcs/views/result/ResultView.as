package com.crowdpark.fastclick.mvcs.views.result
{
	import com.crowdpark.fastclick.mvcs.views.leaderboard.LeaderboardView;

	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class ResultView extends Sprite
	{
		public var resultText : TextField;
		public var result : TextField;
		public var retryButton : Sprite;
		public var leaderboardView : LeaderboardView;
		public var leaderboardTitle:TextField;
		
		public function ResultView()
		{
			resultText = createField("Your Score is", 0, 0, 200, 20, false, "Verdana", 15);
			result = createField("", 0, 0, 200, 20, false, "Verdana", 20);
			resultText = createField("Your Score is", 0, 0, 200, 20, false, "Verdana", 15);
			leaderboardTitle = createField("Highest Scores",0, 0, 200, 20, false, "Verdana", 15);
			
			addChild(result);
			addChild(resultText);
			addChild(leaderboardTitle);
			
			retryButton = new Sprite;
			retryButton.addChild(createRectangleShape(80, 30));

			var title : TextField = createField("Retry", 0, 0, 200, 20, false, "Verdana", 15, 0xffffff);
			title.x = (retryButton.width - title.textWidth) / 2;

			retryButton.addChild(title);

			addChild(retryButton);

			leaderboardView = new LeaderboardView();
			addChild(leaderboardView);
		}
	}
}
