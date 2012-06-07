package com.crowdpark.fastclick.mvcs.models.vo
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;
	/**
	 * @author fatmatekin
	 */
	public class PlayerVo extends BaseVo
	{
		public function getPlayerName() : String
		{
			return String(getValueByKey('playerName'));
		}

		public function setPlayerName(playerName : String) : PlayerVo
		{
			this.setValueByKey('playerName', playerName);
			return this;
		}

		public function getCurrentScore() : uint
		{
			return uint(getValueByKey('currentScore'));
		}

		public function setCurrentScore(score : uint) : PlayerVo
		{
			this.setValueByKey('currentScore', score);
			return this;
		}

	}
}
