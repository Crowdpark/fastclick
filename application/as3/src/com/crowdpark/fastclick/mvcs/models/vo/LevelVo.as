package com.crowdpark.fastclick.mvcs.models.vo
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;

	/**
	 * @author fatmatekin
	 */
	public class LevelVo extends BaseVo
	{
		public function getLevelIndex() : uint
		{
			return uint(this.getValueByKey('levelIndex'));
		}

		public function setLevelIndex(index : uint) : void
		{
			this.setValueByKey('levelIndex', index);
		}

		public function getGameDuration() : uint
		{
			return uint(this.getValueByKey('gameDuration'));
		}

		public function setGameDuration(gameDuration : uint) : void
		{
			this.setValueByKey('gameDuration', gameDuration);
		}

		public function getScoreLimit() : uint
		{
			return uint(this.getValueByKey('scoreLimit'));
		}

		public function setScoreLimit(scoreLimit : uint) : void
		{
			this.setValueByKey('scoreLimit', scoreLimit);
		}
	}
}
