package com.crowdpark.fastclick.mvcs.views.game
{
	import com.crowdpark.fastclick.mvcs.views.footer.FooterView;
	import com.crowdpark.fastclick.mvcs.views.leaderboard.LeaderboardView;
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.points.PointsView;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class GameView extends Sprite
	{
		public var hudView : HudView;
		public var pointsView : PointsView;
		public var leaderboardView : LeaderboardView;
		public var footerView : FooterView;

		public function GameView()
		{
			init();
		}

		private function init() : void
		{
			pointsView = new PointsView();
			addChild(pointsView);

			hudView = new HudView();
			addChild(hudView);

			leaderboardView = new LeaderboardView();
			addChild(leaderboardView);

			footerView = new FooterView();
			footerView.name = "footerView";
			addChild(footerView);
		}
	}
}
