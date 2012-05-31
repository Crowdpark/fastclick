package com.crowdpark.fastclick.mvcs.models
{
	import flash.geom.Point;

	import com.crowdpark.fastclick.mvcs.models.vo.BallVo;
	import com.crowdpark.fastclick.mvcs.models.vo.BaseVo;

	import flash.utils.Timer;

	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewEvent;

	import flash.events.TimerEvent;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class ConfigModel extends Actor
	{
		private var _ballArray : Array;
		private var _time : uint;
		private var _timer : Timer;
		private var _gameDuration : BaseVo;
		[Inject]
		public var playerModel : PlayerModel;

		public function addBall(ball : BallVo) : void
		{
			getBallArray().push(ball);
		}

		public function getBallArray() : Array
		{
			if (!_ballArray)
			{
				_ballArray = new Array();
			}
			return _ballArray;
		}

		public function setBallArray(ballArray : Array) : ConfigModel
		{
			this._ballArray = ballArray;
			return this;
		}

		public function getTime() : uint
		{
			return _time;
		}

		public function setTime(time : uint) : ConfigModel
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
			setTime(uint(getGameDuration().value) - _timer.currentCount);
			dispatch(new HudViewEvent(HudViewEvent.UPDATE));

			if (getTime() == 0)
			{
				_timer.stop();
				dispatch(new StateMachineEvents(StateMachineEvents.FINISH));
				dispatch(new LeaderboardEvent(LeaderboardEvent.SORT, playerModel.getPlayerName()));
			}
		}

		public function getGameDuration() : BaseVo
		{
			return _gameDuration;
		}

		public function setGameDuration(gameDuration : BaseVo) : ConfigModel
		{
			this._gameDuration = gameDuration;
			return this;
		}

		public function saveData(data : Object) : void
		{
			var resultArray : Array = data.getValue().points;

			var baseVo : BaseVo = new BaseVo("gameDuration", data.getValue().gameDuration);

			setGameDuration(baseVo);

			for each (var point:Object in resultArray)
			{
				var ballVO : BallVo = new BallVo();
				ballVO.setEndPoint(new BaseVo("endPoint", new Point(60, 370)));
				ballVO.setColor(new BaseVo("color", point.color));
				ballVO.setScore(new BaseVo("score", point.score));
				addBall(ballVO);
			}
		}
	}
}
