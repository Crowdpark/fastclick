package com.crowdpark.fastclick.mvcs.models.vo
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;

	/**
	 * @author fatmatekin
	 */
	public class ScoreVo extends BaseVo
	{
		public function setScore(score : uint) : ScoreVo
		{
			this.setValueByKey('score', score);
			return this;
		}

		public function getScore() : uint
		{
			return uint(this.getValueByKey('score'));
		}

		public function getDate() : Date
		{
			return Date(this.getValueByKey('date'));
		}

		public function setDate(timeStamp : Number) : ScoreVo
		{
			var date : Date = new Date(timeStamp * 1000);

			this.setValueByKey('date', date);
			return this;
		}
	}
}
