package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.net.SharedObject;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _score : uint = 0;
		private var _playerName : String;
		private var _scoreArray : Array;
		private var _flashCookie : SharedObject;
		private var _currentPlayer : PlayerVo;
		private var _playerArray : Array;

		public function PlayerModel()
		{
		}

		public function addPlayer(player : PlayerVo) : PlayerModel
		{
			getPlayerArray().push(player);
			return this;
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

		public function getCurrentPlayer() : PlayerVo
		{
			return _currentPlayer;
		}

		public function setCurrentPlayer(player : PlayerVo) : PlayerModel
		{
			this._currentPlayer = player;
			return this;
		}

		public function getPlayerArray() : Array
		{
			if (!_playerArray)
			{
				_playerArray = new Array();
			}
			return _playerArray;
		}

		public function setPlayerArray(playerArray : Array) : PlayerModel
		{
			this._playerArray = playerArray;
			return this;
		}
	}
}
