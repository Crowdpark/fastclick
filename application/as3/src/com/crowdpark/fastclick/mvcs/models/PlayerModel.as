package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Actor;

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
		private var _playerApplicationFriends : Vector.< PlayerVo>;
		public var _currentFetchIndex : uint = 0;

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

		public function createPlayer(playerName : String, playerLastName : String, id : uint) : PlayerVo
		{
			var currentPlayer : PlayerVo = getCurrentPlayer();
			currentPlayer.setPlayerName(playerName);
			currentPlayer.setPlayerLastName(playerLastName);
			currentPlayer.setPlayerId(id);
			currentPlayer.setCurrentScore(0);
			currentPlayer.setCurrentLevel(1);
			currentPlayer.setClickedBallAmount(0);
			currentPlayer.setPlayerPictureUrl('https://graph.facebook.com/' + id + '/picture');

			setCurrentPlayer(currentPlayer);

			var event : GameEvents = new GameEvents(GameEvents.SET_PLAYER_COOKIE);
			event.setDataprovider(currentPlayer);
			dispatch(event);

			return currentPlayer;
		}

		public function createFriend(index : uint) : void
		{
			var appfriend : Object = getCurrentPlayer().getFriendsList()[index];
			var playerVo : PlayerVo = new PlayerVo();
			playerVo.setPlayerId(appfriend.id);
			playerVo.setPlayerFullName(appfriend.name);
			playerVo.setPlayerType('friend');
			playerVo.setPlayerPictureUrl('http://graph.facebook.com/' + appfriend.id + '/picture');
			playerVo.setCurrentLevel(0);
			playerVo.setCurrentScore(0);
			playerVo.setFetchIndex(index);

			getPlayerFriends().push(playerVo);

			var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.FETCH_BITMAP);
			dispatch(bitmapFetcherServiceEvent);
		}

		public function getPlayerAppFriends() : Vector.<PlayerVo>
		{
			if (!_playerApplicationFriends)
			{
				_playerApplicationFriends = new Vector.<PlayerVo>();
			}
			return _playerApplicationFriends;
		}

		public function setPlayerApplicationFriends(playerApplicationFriends : Vector.<PlayerVo>) : void
		{
			_playerApplicationFriends = playerApplicationFriends;
		}

		public function setCurrentLevel(user : Object) : void
		{
			trace(user.level + ' user currentlevel');

			getCurrentPlayer().setCurrentLevel(user.level);
		}

		public function setSelectedLevel(level : uint)
		{
			getCurrentPlayer().setSelectedLevel(level);
		}

		public function filterAppFriends() : void
		{
			var allFriends : Vector.<PlayerVo> = getPlayerFriends();
			var appFriends = getCurrentPlayer().getAppFriendsList();

			for (var i : uint = 0;i < appFriends.length;i++)
			{
				for (var j : uint = 0; j < allFriends.length;j++)
				{
					if (appFriends[i].id == allFriends[j].getPlayerId())
					{
						allFriends[j].setPlayerType('appfriend');

						var gameEvent : GameEvents = new GameEvents(GameEvents.CREATE_APP_FRIEND);
						gameEvent.getDataprovider().setValueByKey('currentFriend', allFriends[j]);
						dispatch(gameEvent);
					}
				}
			}
		}
	}
}
