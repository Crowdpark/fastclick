package com.crowdpark.fastclick.mvcs.assets.ball
{
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class RedBall extends BaseGraphic
	{		
		override public function getColor() : uint
		{
			return 0xff0000;
		}

		override public function getEndPoint() : Point
		{
			if (!getEndPoint)
			{
				setEndPoint(new Point(this.x, stage.y - this.height));
			}
			return super.getEndPoint();
		}
	}
}
