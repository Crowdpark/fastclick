package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Bitmap;
	import flash.net.SharedObject;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _flashCookie : SharedObject;
		private var _currentPlayer : PlayerVo;
		private var _playerArray : Vector.<PlayerVo>;
		private var _playerFriends : Vector.<PlayerVo>;
		private var _loadedFriends : Vector.<PlayerVo>;
		public var _currentFetchIndex : uint = 0;
		private var _currentList : Object = new Object();
		private var _playerAppFriends : Vector.<PlayerVo>;
		public var appLoaded : Boolean = true;

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

		public function getCurrentPlayer() : PlayerVo
		{
			if (!_currentPlayer)
			{
				_currentPlayer = new PlayerVo();
			}
			return _currentPlayer;
		}

		public function setCurrentPlayer(player : PlayerVo) : PlayerModel
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

		public function getPlayerFriends() : Vector.<PlayerVo>
		{
			if (!_playerFriends)
			{
				_playerFriends = new Vector.<PlayerVo>();
			}
			return _playerFriends;
		}

		public function setPlayerFriends(playerFriends : Vector.<PlayerVo>) : PlayerModel
		{
			this._playerFriends = playerFriends;
			return this;
		}

		public function createPlayer(playerName : String, playerLastName : String, id : String) : PlayerVo
		{
			var currentPlayer : PlayerVo = getCurrentPlayer();
			currentPlayer.setPlayerName(playerName);
			currentPlayer.setPlayerLastName(playerLastName);
			currentPlayer.setPlayerId(id);

			var score : ScoreVo = new ScoreVo().setScore(0).setDate(0);

			currentPlayer.setCurrentScore(score);
			currentPlayer.setCurrentLevel(1);
			currentPlayer.setClickedBallAmount(0);
			currentPlayer.setPlayerPictureUrl('https://graph.facebook.com/' + id + '/picture');

			setCurrentPlayer(currentPlayer);

			var event : GameEvents = new GameEvents(GameEvents.SET_PLAYER_COOKIE);
			event.setDataprovider(currentPlayer);
			dispatch(event);

			return currentPlayer;
		}

		public function setCurrentLevel(level : uint) : void
		{
			trace(level + ' user currentlevel');

			getCurrentPlayer().setCurrentLevel(level);
		}

		public function setSelectedLevel(level : uint)
		{
			getCurrentPlayer().setSelectedLevel(level);
		}

		public function getLoadedFriends() : Vector.<PlayerVo>
		{
			if (!_loadedFriends)
			{
				_loadedFriends = new Vector.<PlayerVo>();
			}
			return _loadedFriends;
		}

		public function setLoadedFriends(loadedFriends : Vector.<PlayerVo>) : PlayerModel
		{
			_loadedFriends = loadedFriends;
			return this;
		}

		public function setCurrentList(currentList : *) : void
		{
			_currentList = currentList;
		}

		public function getCurrentList() : Object
		{
			return _currentList;
		}

		public function createFriendVo(bitmap : Bitmap, index : uint) : void
		{
			var friend = getCurrentPlayer().getFriendsList();

			if (friend)
			{
				var playerVo : PlayerVo = new PlayerVo();

				playerVo.setPlayerPicture(bitmap);
				playerVo.setPlayerId(friend.id);

				getLoadedFriends().push(playerVo);
			}
		}

		public function getPlayerAppFriends() : Vector.<PlayerVo>
		{
			if (!_playerAppFriends)
			{
				_playerAppFriends = new Vector.<PlayerVo>();
			}
			return _playerAppFriends;
		}

		public function setPlayerAppFriends(playerAppFriends : Vector.<PlayerVo>) : void
		{
			_playerAppFriends = playerAppFriends;
		}

		public function createAppFriendVos(arr : Array) : void
		{
			for (var i : uint = 0;i < arr.length;i++)
			{
				var friend = getCurrentPlayer().getAppFriendsList()[i];
				var playerVo : PlayerVo = new PlayerVo();

				playerVo.setPlayerPicture(arr[i]);
				playerVo.setPlayerId(friend.id);

				playerVo.setPlayerType(friend.type);
				playerVo.setPlayerFullName(friend.name);
				playerVo.setCurrentLevel(friend.level);

				var score : ScoreVo = new ScoreVo();
				score.setScore(friend.high_score);
				playerVo.setCurrentScore(score);

				getLoadedFriends().push(playerVo);

				var gameEvent : GameEvents = new GameEvents(GameEvents.CREATE_APP_FRIEND);
				gameEvent.getDataprovider().setValueByKey('currentFriend', playerVo);
				dispatch(gameEvent);
			}
		}
	}
}
