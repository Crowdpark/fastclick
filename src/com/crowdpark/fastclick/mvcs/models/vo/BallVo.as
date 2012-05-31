package com.crowdpark.fastclick.mvcs.models.vo
{
	/**
	 * @author fatmatekin
	 */
	public class BallVo
	{
		private var _endPoint : BaseVo;
		private var _color : BaseVo;
		private var _score : BaseVo;

		public function getEndPoint() : BaseVo
		{
			return _endPoint;
		}

		public function setEndPoint(endPoint : BaseVo) : BallVo
		{
			this._endPoint = endPoint;
			return this;
		}

		public function getColor() : BaseVo
		{
			return _color;
		}

		public function setColor(color : BaseVo) : BallVo
		{
			this._color = color;
			return this;
		}

		public function getScore() : BaseVo
		{
			return _score;
		}

		public function setScore(score : BaseVo) : BallVo
		{
			this._score = score;
			return this;
		}
	}
}
