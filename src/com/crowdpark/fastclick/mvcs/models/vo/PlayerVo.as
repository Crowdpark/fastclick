package com.crowdpark.fastclick.mvcs.models.vo
{
	/**
	 * @author fatmatekin
	 */
	public class PlayerVo
	{
		private var _playerName : BaseVo;
		private var _currentScore : BaseVo;
		private var _scoreArray : Array;

		public function PlayerVo(playerName : BaseVo)
		{
			this.playerName = playerName;
		}

		public function get playerName() : BaseVo
		{
			return _playerName;
		}

		public function set playerName(playerName : BaseVo) : void
		{
			this._playerName = playerName;
		}

		public function getCurrentScore() : BaseVo
		{
			if (!_currentScore)
			{
				var currentBaseVo:BaseVo = new BaseVo("currentScore", 0);
				_currentScore = currentBaseVo;
			}
			return _currentScore;
		}

		public function setCurrentScore(score : uint) : PlayerVo
		{
			var scoreBaseVo : BaseVo = new BaseVo("currentScore", score);
			this._currentScore = scoreBaseVo;
			return this;
		}

		public function getScoreArray() : Array
		{
			if (!_scoreArray)
			{
				_scoreArray = new Array();
			}
			return _scoreArray;
		}

		public function setScoreArray(scoreArray : Array) : PlayerVo
		{
			this._scoreArray = scoreArray;
			return this;
		}

		public function addNewScore() : void
		{
			getScoreArray().push(getCurrentScore());
		}
	}
}
