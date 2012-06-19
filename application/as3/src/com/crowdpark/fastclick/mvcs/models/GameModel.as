package com.crowdpark.fastclick.mvcs.models
{
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class GameModel extends Actor
	{
		public static const REPLAY : String = "REPLAY";
		private var _state : String;

		public function setState(state : String) : GameModel
		{
			this._state = state;
			return this;
		}

		public function getState() : String
		{
			return this._state;
		}
	}
}
