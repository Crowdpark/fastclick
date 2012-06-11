package com.crowdpark.fastclick.mvcs.models.vo
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class BallVo extends BaseVo
	{
		public function getEndPoint() : Point
		{
			return Point(this.getValueByKey('endPoint'));
		}

		public function setEndPoint(endPoint : Point) : BallVo
		{
			this.setValueByKey('endPoint', endPoint);
			return this;
		}

		public function getColor() : uint
		{
			return uint(this.getValueByKey('color'));
		}

		public function setColor(color : uint) : BallVo
		{
			this.setValueByKey('color', color);
			return this;
		}

		public function getScore() : uint
		{
			return uint(this.getValueByKey('score'));
		}

		public function setScore(score : uint) : BallVo
		{
			this.setValueByKey('score', score);
			return this;
		}
	}
}
