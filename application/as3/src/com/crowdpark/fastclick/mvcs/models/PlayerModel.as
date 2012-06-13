package com.crowdpark.fastclick.mvcs.models
{
	import utils.draw.createRectangleShape;

	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.net.SharedObject;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class PlayerModel extends Actor
	{
		private var _flashCookie : SharedObject;
		private var _currentPlayer : PlayerVo;
		private var _playerArray : Vector.<PlayerVo>;
		private var _playerFriends : Vector.<PlayerVo>;

		// [Inject]
		// public var backendService : BackendService;
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
			currentPlayer.setPlayerPictureUrl('https://graph.facebook.com/' + id + '/picture');
			this.setCurrentPlayer(currentPlayer);

			var event : GameEvents = new GameEvents(GameEvents.SET_PLAYER_COOKIE);
			event.setDataprovider(currentPlayer);
			dispatch(event);
		}

		/*public function setFriendsList() : void
		{
		var friendsArray : Vector.<PlayerVo> = new Vector.<PlayerVo>();
		for (var i : uint = 0; i < 4;i++)
		{
		var playerVo : PlayerVo = new PlayerVo();
		playerVo.setPlayerId(1);
		playerVo.setPlayerName('Test-Name');
		playerVo.setPlayerLastName('Test_LastName');
		playerVo.setPlayerPicture(createRectangleShape(60, 40, 0xff0000));
		playerVo.setCurrentLevel(1);
		playerVo.setCurrentScore(19);
		playerVo.setLeaderboardPlace(1);
		friendsArray.push(playerVo);
		}
		setPlayerFriends(friendsArray);

		dispatch(new FacebookServiceEvent(FacebookServiceEvent.FETCH_FRIENDS_IMAGES));
		}*/
		public function setFriendsList(success : Object) : void // Test all friends
		{
			var friendsArray : Vector.<PlayerVo> = new Vector.<PlayerVo>();
			for (var i : uint = 0;i < 15;i++)
			{
				var playerVo : PlayerVo = new PlayerVo();
				playerVo.setPlayerId(success[i].id);
				playerVo.setPlayerFullName(success[i].name);
				playerVo.setPlayerPictureUrl('http://graph.facebook.com/' + success[i].id + '/picture');
				playerVo.setCurrentLevel(1);
				playerVo.setCurrentScore(19);
				playerVo.setLeaderboardPlace(1);
				friendsArray.push(playerVo);
			}
			setPlayerFriends(friendsArray);

			dispatch(new FacebookServiceEvent(FacebookServiceEvent.FETCH_FRIENDS_IMAGES));
		}
	}
}
