package com.crowdpark.fastclick.mvcs.views.game
{
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.points.PointsView;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */	
	public class GameView extends Sprite
	{
		public var hudView:HudView;
		public var pointsView:PointsView;
		
		public function GameView()
		{
			init();	
		}
		private function init():void{
			
			hudView = new HudView();
			addChild(hudView);
			
			pointsView = new PointsView();
			addChild(pointsView);
		}
	}
}
