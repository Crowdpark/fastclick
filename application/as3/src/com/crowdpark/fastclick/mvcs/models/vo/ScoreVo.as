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

		public function getDate() : uint
		{
			return uint(this.getValueByKey('date'));
		}

		public function setDate(timeStamp : uint) : ScoreVo
		{
			this.setValueByKey('date', timeStamp);
			return this;
		}
	}
}
