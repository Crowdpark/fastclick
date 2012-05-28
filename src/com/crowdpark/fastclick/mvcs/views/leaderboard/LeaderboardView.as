package com.crowdpark.fastclick.mvcs.views.leaderboard
{
	import com.bit101.components.Panel;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardView extends Sprite
	{
		public var leaderboardPanel : Panel = new Panel();

		public function LeaderboardView()
		{
			addChild(leaderboardPanel);
		}
	}
}
