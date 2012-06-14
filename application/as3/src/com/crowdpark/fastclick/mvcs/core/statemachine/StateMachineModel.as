package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineModel extends Actor
	{
		private var _state : String;

		public function StateMachineModel()
		{
		}

		public function get state() : String
		{
			return _state;
		}

		public function set state(state : String) : void
		{
			this._state = state;
		}
	}
}
