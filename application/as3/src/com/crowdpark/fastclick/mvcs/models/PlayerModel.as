package com.crowdpark.fastclick.mvcs.models
{
	import flash.display.Bitmap;

	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

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
		private var _loadedFriends : Vector.<PlayerVo>;
		public var _currentFetchIndex : uint = 0;
		private var _appFriendsList : Object = new Object();

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

		public function createFriend(index : uint) : void
		{
			var friendData : Object = getCurrentPlayer().getFriendsList()[index];

			var playerVo : PlayerVo = new PlayerVo();
			playerVo.setPlayerId(friendData.id);
			playerVo.setPlayerFullName(friendData.name);
			playerVo.setPlayerType('friend');
			playerVo.setPlayerPictureUrl('http://graph.facebook.com/' + friendData.id + '/picture');
			playerVo.setCurrentLevel(0);

			var score : ScoreVo = new ScoreVo().setScore(friendData.high_score);

			playerVo.setCurrentScore(score);
			playerVo.setFetchIndex(index);

			getPlayerFriends().push(playerVo);
			var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.FETCH_BITMAP);
			dispatch(bitmapFetcherServiceEvent);
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

		public function filterAppFriends() : void
		{
			var allFriends : Vector.<PlayerVo> = getPlayerFriends();
			var appFriends = getCurrentPlayer().getAppFriendsList();

			if (appFriends)
			{
				startFilter(allFriends, appFriends);
			}
		}

		private function startFilter(allFriends : Vector.<PlayerVo>, appFriends : *) : void
		{
			for (var i : uint = 0;i < appFriends.length;i++)
			{
				for (var j : uint = 0; j < allFriends.length;j++)
				{
					if (String(appFriends[i].id) == String(allFriends[j].getPlayerId()))
					{
						allFriends[j].setPlayerType('appfriend');
						var score : ScoreVo = new ScoreVo();
						score.setScore(appFriends[i].high_score);
						allFriends[j].setCurrentScore(score);
						allFriends[j].setCurrentLevel(appFriends[i].level);

						var gameEvent : GameEvents = new GameEvents(GameEvents.CREATE_APP_FRIEND);
						gameEvent.getDataprovider().setValueByKey('currentFriend', allFriends[j]);
						dispatch(gameEvent);
					}
				}
			}
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

		public function startFetchingBitmaps(friendData) : void
		{
			// var friendData : Object = getCurrentPlayer().getFriendsList();

			for (var i : uint = 0;i < friendData.length;i++)
			{
				var url : String = 'http://graph.facebook.com/' + friendData[i].id + '/picture';

				var bitmapFetcherServiceEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.FETCH_BITMAP);
				bitmapFetcherServiceEvent.getDataprovider().setValueByKey('url', url);
				dispatch(bitmapFetcherServiceEvent);
			}
		}

		public function createFriendVo(bitmap : Bitmap, index : uint) : void
		{
			var friend = getCurrentPlayer().getFriendsList()[index];
			if (friend)
			{
				var playerVo : PlayerVo = new PlayerVo();
				getLoadedFriends().push(playerVo);
				playerVo.setPlayerId(friend.id);
				playerVo.setPlayerPicture(bitmap);

				if (friend.type == 'appfriend')
				{
					playerVo.setPlayerType(friend.type);
					playerVo.setPlayerFullName(friend.name);
					playerVo.setCurrentLevel(friend.level);

					var score : ScoreVo = new ScoreVo();
					score.setScore(friend.high_score);
					playerVo.setCurrentScore(score);

					var gameEvent : GameEvents = new GameEvents(GameEvents.CREATE_APP_FRIEND);
					gameEvent.getDataprovider().setValueByKey('currentFriend', playerVo);
					dispatch(gameEvent);
				}
			}
		}

		private function getAppFriendsList() : Object
		{
			return _appFriendsList;
		}
	}
}
