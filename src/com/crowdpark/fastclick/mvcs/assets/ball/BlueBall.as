package com.crowdpark.fastclick.mvcs.assets.ball
{
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class BlueBall extends BaseBall
	{
		override public function getColor() : uint
		{
			return 0x0080ff;
		}

		override public function getEndPoint() : Point
		{
			if (!getEndPoint)
			{
				setEndPoint(new Point(stage.width, getStartPoint().y));
			}
			return super.getEndPoint();
		}
	}
}
