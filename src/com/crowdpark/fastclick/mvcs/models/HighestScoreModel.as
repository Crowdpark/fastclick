package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class HighestScoreModel extends Actor
	{
		private var _highscoreList : Vector.<PlayerVo> = new Vector.<PlayerVo>();

		public function getHighscoreList() : Vector.<PlayerVo>
		{
			return _highscoreList;
		}

		public function setHighscoreList(highscoreList : Vector.<PlayerVo>) : HighestScoreModel
		{
			_highscoreList = highscoreList;
			return this;
		}
	}
}
