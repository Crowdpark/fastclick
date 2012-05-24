package com.crowdpark.fastclick.mvcs.views
{
	import utils.number.randomIntegerWithinRange;
	import utils.draw.createCircleShape;
	import utils.geom.randomPoint;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class PointsView extends Sprite
	{
		public function PointsView()
		{
		}
		public function createRandomSizedPoint():Sprite{
			
			var circle:Sprite = new Sprite();
			circle.addChild(createCircleShape(randomIntegerWithinRange(15,30)));
			circle.buttonMode = true;
			
			circle.x =randomPoint(0,400, 50, 400).x;
			circle.y = randomPoint(0,400, 50, 400).y;
			
			return circle;
		}
	}
}
