package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
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
		private var _currentFetchPicturePlayer : PlayerVo;

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

		public function createPlayer(playerName : String, playerLastName : String, id : uint) : void
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
		}

		public function setAllFriends(appFriends : Object) : void
		{
			var amount = appFriends.length - 10;
			for (var i : uint = appFriends.length - 1;i > amount;i--)
			{
				var appfriend = appFriends[i];
				var playerVo : PlayerVo = new PlayerVo();
				playerVo.setPlayerId(appfriend.id);
				playerVo.setPlayerFullName(appfriend.name);
				playerVo.setPlayerType(appfriend.type);
				playerVo.setPlayerPictureUrl('http://graph.facebook.com/' + appfriend.id + '/picture');
				playerVo.setCurrentLevel(appfriend.level);
				playerVo.setCurrentScore(appfriend.high_score);
				getPlayerFriends().push(playerVo);

				// var bitmapLoaderService : BitmapLoaderServiceEvent = new BitmapLoaderServiceEvent(BitmapLoaderServiceEvent.LOAD_BITMAP);
				// bitmapLoaderService.getDataprovider().setValueByKey('currentPlayer', playerVo);
				// dispatch(bitmapLoaderService);
			}
			dispatch(new FacebookServiceEvent(FacebookServiceEvent.FETCH_ALL_FRIENDS_PICTURES));
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

		public function setCurrentFetchPicturePlayer(currentPlayer : PlayerVo) : PlayerModel
		{
			_currentFetchPicturePlayer = currentPlayer;
			return this;
		}

		public function getCurrentFetchPicturePlayer() : PlayerVo
		{
			return _currentFetchPicturePlayer;
		}
	}
}
