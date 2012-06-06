package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.net.SharedObject;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _flashCookie : SharedObject;
		private var _currentPlayer : InterfaceVO;
		private var _playerArray : Vector.<PlayerVo>;

		public function addPlayer(player : PlayerVo) : PlayerModel
		{
			getPlayerArray().push(player);
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

		public function getCurrentPlayer() : InterfaceVO
		{
			return _currentPlayer;
		}

		public function setCurrentPlayer(player : InterfaceVO) : PlayerModel
		{
			this._currentPlayer = player;
			return this;
		}

		public function getPlayerArray() : Vector.<PlayerVo>
		{
			if (!_playerArray)
			{
				_playerArray = new Vector.<PlayerVo>();
			}
			return _playerArray;
		}

		public function setPlayerArray(playerArray : Vector.<PlayerVo>) : PlayerModel
		{
			this._playerArray = playerArray;
			return this;
		}
	}
}
