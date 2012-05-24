package com.crowdpark.fastclick.mvcs.models
{
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _score : uint = 0;
		public function PlayerModel()
		{
		}

		public function get score() : uint
		{
			return _score;
		}

		public function set score(score : uint) : void
		{
			this._score = score;
		}
	}
}
