package com.crowdpark.fastclick.mvcs.views.points
{
	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.assets.FastClickCircle;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class PointsView extends Sprite
	{
		public function PointsView()
		{
		}

		public function createRandomSizedPoint() : FastClickCircle
		{
			var fastClickCircle : FastClickCircle = new FastClickCircle();
			
			fastClickCircle.setRandomColor();
			fastClickCircle.drawCircle(randomIntegerWithinRange(15, 30));
			fastClickCircle.setRandomPoint();
			fastClickCircle.setDirection();
		
			return fastClickCircle;
		}
	}
}
