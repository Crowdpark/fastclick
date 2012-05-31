package com.crowdpark.fastclick.mvcs.models.vo
{
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

		public function getScoreArray() : Array
		{
			return (this.getValueByKey('scoreArray') as Array);
		}

		public function setScoreArray(scoreArray : Array) : PlayerVo
		{
			this.setValueByKey('scoreArray', scoreArray);
			return this;
		}

		public function addNewScore() : void
		{
			getScoreArray().push(getCurrentScore());
		}
	}
}
