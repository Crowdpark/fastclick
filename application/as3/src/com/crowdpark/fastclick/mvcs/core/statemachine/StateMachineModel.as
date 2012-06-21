package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineModel extends Actor
	{
		private var _state : String;
		private var _gameState : String;
		
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

		public function getGameState() : String
		{
			return _gameState;
		}

		public function setGameState(gameState : String) : StateMachineModel
		{
			this._gameState = gameState;
			return this;
		}
	}
}
