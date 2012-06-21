package com.crowdpark.fastclick.mvcs.views.game
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.views.footer.FooterView;
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.points.PointsView;

		/**
	 * @author fatmatekin
	 */
	public class GameView extends BaseView
	{
		public var hudView : HudView;
		public var pointsView : PointsView;
		public var footerView : FooterView;

		override public function init() : void
		{
			pointsView = new PointsView();
			addChild(pointsView);

			hudView = new HudView();
			hudView.y = 60;
			hudView.init();
			addChild(hudView);

			footerView = new FooterView();
			footerView.init();
			addChild(footerView);
			
		}
	}
}
