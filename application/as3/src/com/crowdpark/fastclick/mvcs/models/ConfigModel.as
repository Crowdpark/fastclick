package com.crowdpark.fastclick.mvcs.models
{
	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
	import com.crowdpark.fastclick.mvcs.models.vo.BallVo;
	import com.crowdpark.fastclick.mvcs.models.vo.LevelVo;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author fatmatekin
	 */
	public class ConfigModel extends Actor
	{
		private var _ballArray : Vector.<BallVo>;
		private var _time : uint;
		private var _timer : Timer;
		private var _gameDuration : uint;
		private var _colorArray : Array;
		private var _levelArray : Vector.<LevelVo>;
		private var _url : String;
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

		public function getTime() : int
		{
			return _time;
		}

		public function setTime(time : int) : ConfigModel
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
			setColorArray(data.getValue().colors);
			setGamelLevels(data.getValue().levels);
			setUrl(data.getValue().url);

			var circleAmount : uint = playerModel.getPlayerFriends().length;
			var colorAmount : uint = getColorArray().length;

			for (var i : uint = 0; i < colorAmount; i++)
			{
				var ballVo : BallVo = new BallVo();
				ballVo.setColor(getColorArray()[randomIntegerWithinRange(0, _colorArray.length - 1)].color);
				ballVo.setScore(10);
				addBall(ballVo);
			}
		}

		private function setGamelLevels(levels : Object) : void
		{
			var levelAmount : uint = levels.length;

			for (var i : uint = 0;i < levelAmount;i++)
			{
				var levelVo : LevelVo = new LevelVo();
				levelVo.setGameDuration(levels[i].gameDuration);
				levelVo.setScoreLimit(levels[i].scoreLimit);
				levelVo.setLevelIndex(levels[i].levelIndex);
				getLevelArray().push(levelVo);
			}
			dispatch(new GameEvents(GameEvents.SHOW_LEVELS));
		}

		public function setColorArray(colors : *) : void
		{
			_colorArray = colors;
		}

		public function getColorArray() : Array
		{
			return _colorArray;
		}

		public function getLevelArray() : Vector.<LevelVo>
		{
			if (!_levelArray)
			{
				_levelArray = new Vector.<LevelVo>();
			}
			return _levelArray;
		}

		public function setLevelArray(levelArray : Vector.<LevelVo>) : ConfigModel
		{
			this._levelArray = levelArray;
			return this;
		}

		public function getUrl() : String
		{
			return _url;
		}

		public function setUrl(url : String) : ConfigModel
		{
			_url = url;
			return this;
		}
	}
}
