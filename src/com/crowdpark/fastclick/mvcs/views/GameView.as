package com.crowdpark.fastclick.mvcs.views
{
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
