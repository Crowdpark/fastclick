package com.crowdpark.fastclick.mvcs.models
{
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

		public function get time() : uint
		{
			return _time;
		}

		public function set time(time : uint) : void
		{
			_time = time;
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
			this.time = 10 - _timer.currentCount;
			dispatch(new HudViewEvent(HudViewEvent.UPDATE));

			if (this.time == 0)
			{
				dispatch(new StateMachineEvents(StateMachineEvents.FINISH));
			}
		}
	}
}
