package com.crowdpark.fastclick.mvcs.models
{
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _score : Number = 0;
		public function PlayerModel()
		{
		}

		public function get score() : Number
		{
			return _score;
		}

		public function set score(score : Number) : void
		{
			this._score = score;
		}
	}
}
