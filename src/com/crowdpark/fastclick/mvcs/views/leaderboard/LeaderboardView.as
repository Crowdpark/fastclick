package com.crowdpark.fastclick.mvcs.views.leaderboard
{
	import flash.text.TextField;

	import com.bit101.components.ScrollPane;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardView extends Sprite
	{
		public var leaderboardPanel : ScrollPane;
		public var playerName : TextField;

		public function LeaderboardView()
		{
			leaderboardPanel = new ScrollPane();
			// playerName = createField("", 0, 0, 200, 20, false, "Verdana", 20, 0);

			leaderboardPanel.setSize(150, 100);
			leaderboardPanel.autoHideScrollBar = true;

			// addChild(playerName);
			addChild(leaderboardPanel);
		}
	}
}
