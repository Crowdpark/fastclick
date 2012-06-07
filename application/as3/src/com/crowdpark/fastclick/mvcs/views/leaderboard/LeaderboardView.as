package com.crowdpark.fastclick.mvcs.views.leaderboard
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import flash.text.TextField;

	import com.bit101.components.ScrollPane;

	
	/**
	 * @author fatmatekin
	 */
	public class LeaderboardView extends BaseView
	{
		public var leaderboardPanel : ScrollPane;
		public var playerName : TextField;

		override public function init() :void
		
		{
			leaderboardPanel = new ScrollPane();
			leaderboardPanel.color = 0xffffff;
			leaderboardPanel.shadow = false;
			leaderboardPanel.showGrid = false;
			leaderboardPanel.gridColor = 0xffffff;

			leaderboardPanel.setSize(150, 120);
			leaderboardPanel.autoHideScrollBar = true;
			addChild(leaderboardPanel);
			
			
		}
	}
}
