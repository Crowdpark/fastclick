package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class HighestScoreModel extends Actor
	{
		private var _highscoreList : Vector.<ScoreVo> = new Vector.<ScoreVo>();

		public function getHighscoreList() : Vector.<ScoreVo>
		{
			if (!_highscoreList)
			{
				_highscoreList = new Vector.<ScoreVo>();
			}

			return _highscoreList;
		}

		public function setHighscoreList(highscoreList : Vector.<ScoreVo>) : HighestScoreModel
		{
			_highscoreList = highscoreList;
			return this;
		}

		public function addScore(score : ScoreVo) : void
		{
			getHighscoreList().push(score);
			sortHighestScores();
		}

		public function sortHighestScores() : void
		{
			getHighscoreList().sort(sortScoreVos);
		}

		private function sortScoreVos(x : ScoreVo, y : ScoreVo) : Number
		{
			var scoreSort : Number = sortScores(x.getScore(), y.getScore());
			return scoreSort;
		}

		private function sortScores(x : uint, y : uint) : Number
		{
			if (x > y)
			{
				return -1;
			}
			else if (x < y)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}
}
