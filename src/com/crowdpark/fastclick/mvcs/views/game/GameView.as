package com.crowdpark.fastclick.mvcs.views.game
{
	import com.crowdpark.fastclick.mvcs.views.footer.FooterView;
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
		public var footerView : FooterView;

		public function init() : GameView
		{
			pointsView = new PointsView();
			addChild(pointsView);

			hudView = new HudView();
			hudView.name = "hudView";
			addChild(hudView);

			footerView = new FooterView();
			addChild(footerView);
			return this;
		}
	}
}
