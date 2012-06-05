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

		public function init(): LeaderboardView
		{
			leaderboardPanel = new ScrollPane();
			leaderboardPanel.color = 0xffffff;
			leaderboardPanel.shadow = false;
			leaderboardPanel.showGrid = false;
			leaderboardPanel.gridColor = 0xffffff;

			leaderboardPanel.setSize(150, 120);
			leaderboardPanel.autoHideScrollBar = true;
			addChild(leaderboardPanel);
			
			return this;
		}
	}
}
