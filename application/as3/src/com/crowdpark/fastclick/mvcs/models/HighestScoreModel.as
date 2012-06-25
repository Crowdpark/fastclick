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
		private var _allLevelsList : Object;

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

		public function addScore(score : ScoreVo, currentLevel : uint) : void
		{
			// getHighscoreList().push(score);
			// sortHighestScores();
			var currentList : Vector.<ScoreVo> = getAllLevelsList()[String(currentLevel)];
			if (!currentList)
			{
				var newScoreList : Vector.<ScoreVo> = new Vector.<ScoreVo>();
				currentList = newScoreList;
				getAllLevelsList()[String(currentLevel)] = currentList;
			}
			currentList.push(score);
			sortHighestScores(currentList);
		}

		public function sortHighestScores(scoreList : Vector.<ScoreVo>) : Vector.<ScoreVo>
		{
			// getHighscoreList().sort(sortScoreVos);
			scoreList.sort(sortScoreVos);
			return scoreList;
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

		public function createHighestScoreLists(result : Object) : void
		{
			for (var key:String in result )
			{
				_allLevelsList[key] = createLevelScoreList(result[key]);
			}
		}

		public function createLevelScoreList(scores : Object) : Vector.<ScoreVo>
		{
			var scoreList : Vector.<ScoreVo> = new Vector.<ScoreVo>();
			for (var key:String in scores)
			{
				var score : ScoreVo = new ScoreVo().setScore(scores[key]).setDate(uint(key));
				scoreList.push(score);
			}
			return sortHighestScores(scoreList);
		}

		public function getAllLevelsList() : Object
		{
			if (!_allLevelsList)
			{
				_allLevelsList = new Object();
			}
			return _allLevelsList;
		}

		public function setAllLevelsList(allLevelsList : Object) : HighestScoreModel
		{
			_allLevelsList = allLevelsList;
			return this;
		}
	}
}
