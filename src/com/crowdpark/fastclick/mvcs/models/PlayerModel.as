package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import flash.net.SharedObject;

	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewEvent;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _score : uint = 0;
		private var _timer : Timer;
		private var _time : uint;
		private var _playerName : String;
		private var _scoreArray : Array;
		private var _flashCookie : SharedObject;

		public function PlayerModel()
		{
		}

		public function getScore() : uint
		{
			if (!this._score)
			{
				this._score = 0;
			}
			return _score;
		}

		public function setScore(score : uint) : PlayerModel
		{
			this._score = score;
			return this;
		}

		public function getTime() : uint
		{
			return _time;
		}

		public function setTime(time : uint) : PlayerModel
		{
			_time = time;
			return this;
		}

		public function  updateTimer() : void
		{
			dispatch(new HudViewEvent(HudViewEvent.UPDATE));
		}

		public function startTimer() : void
		{
			_timer = new Timer(500, 0);
			_timer.addEventListener(TimerEvent.TIMER, handleTimer);
			_timer.start();
		}

		private function handleTimer(e : TimerEvent) : void
		{
			setTime(10 - _timer.currentCount);
			dispatch(new HudViewEvent(HudViewEvent.UPDATE));

			if (getTime() == 0)
			{
				_timer.stop();
				dispatch(new StateMachineEvents(StateMachineEvents.FINISH));
				dispatch(new LeaderboardEvent(LeaderboardEvent.SORT, getPlayerName()));
				
			}
		}

		public function getPlayerName() : String
		{
			return _playerName;
		}

		public function setPlayerName(playerName : String) : PlayerModel
		{
			this._playerName = playerName;
			return this;
		}

		public function addNewScore() : void
		{
			getScoreArray().push(getScore());
		}

		public function getScoreArray() : Array
		{
			if (!_scoreArray)
			{
				_scoreArray = new Array();
			}
			_scoreArray.sort(Array.DESCENDING);
			_scoreArray.sort(Array.NUMERIC);
			_scoreArray.reverse();
			
			return _scoreArray;
		}

		public function setScoreArray(scoreArray : Array) : PlayerModel
		{
			this._scoreArray = scoreArray;
			return this;
		}

		public function getFlashCookie() : SharedObject
		{
			if (!_flashCookie)
			{
				_flashCookie = SharedObject.getLocal("MyFlashCookie");
				_flashCookie.flush();
			}
			return _flashCookie;
		}

		public function setFlashCookie(flashCookie : SharedObject) : PlayerModel
		{
			this._flashCookie = flashCookie;
			this._flashCookie.flush();
			return this;
		}
	}
}
