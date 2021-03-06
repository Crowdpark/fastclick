package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
	import com.crowdpark.fastclick.mvcs.models.vo.BallVo;
	import com.crowdpark.fastclick.mvcs.models.vo.BaseVo;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewEvent;

	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class ConfigModel extends Actor
	{
		private var _ballArray : Vector.<BallVo>;
		private var _time : uint;
		private var _timer : Timer;
		private var _gameDuration : uint;
		[Inject]
		public var playerModel : PlayerModel;

		public function addBall(ball : InterfaceVO) : void
		{
			getBallArray().push(ball);
		}

		public function getBallArray() : Vector.<BallVo>
		{
			if (!_ballArray)
			{
				_ballArray = new Vector.<BallVo>();
			}
			return _ballArray;
		}

		public function setBallArray(ballArray : Vector.<BallVo>) : ConfigModel
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
			_timer = new Timer(1000, 0);
			_timer.addEventListener(TimerEvent.TIMER, handleTimer);
			_timer.start();
		}

		private function handleTimer(e : TimerEvent) : void
		{
			setTime(getGameDuration() - _timer.currentCount);
			dispatch(new HudViewEvent(HudViewEvent.UPDATE));

			if (getTime() == 0)
			{
				_timer.stop();
				dispatch(new StateMachineEvents(StateMachineEvents.FINISH));

				var bvo : InterfaceVO = new BaseVo();
				bvo.setValueByKey('playerName', String(playerModel.getCurrentPlayer().getValueByKey('playerName')));
				dispatch(new LeaderboardEvent(LeaderboardEvent.SORT).setDataprovider(bvo));
			}
		}

		public function getGameDuration() : uint
		{
			return _gameDuration;
		}

		public function setGameDuration(gameDuration : uint) : ConfigModel
		{
			this._gameDuration = gameDuration;
			return this;
		}

		public function saveData(data : Object) : void
		{
			var resultArray : Array = data.getValue().points;

			setGameDuration(data.getValue().gameDuration);

			for each (var point:Object in resultArray)
			{
				var ballVO : BallVo = new BallVo();
				ballVO.setValueByKey('endPoint', new Point(60, 370));
				ballVO.setValueByKey('color', point.color);
				ballVO.setValueByKey('score', point.score);
				addBall(ballVO);
			}
		}
	}
}
