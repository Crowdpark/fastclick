package com.crowdpark.fastclick.mvcs.services
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.system.Security;

	import com.facebook.graph.Facebook;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;

	/**
	 * @author fatmatekin
	 */
	public class FacebookService extends Actor
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendService : BackendService;
		
		[Inject]
		public var configService : ConfigService;
		
		private var friendIndex : uint = 0;
		private var loader : Loader;

		public function init() : void
		{
			Security.allowDomain('http://profile.ak.fbcdn.net');
			Security.allowInsecureDomain('http://profile.ak.fbcdn.net');
			
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");

			ExternalInterface.addCallback("onMe", onMe);
			ExternalInterface.addCallback("onFetchFriends", onFetchFriends);
		}

		private function onMe(params : Object) : void
		{
			playerModel.createPlayer(String(params.first_name), String(params.last_name), uint(params.id));
		}

		private function onFetchFriends(params : Object) : void
		{
			playerModel.setFriendsList(params.data); //Test all friends	
			configService.fetchData("data/Config.json");

			playerModel.getCurrentPlayer().setFriendsList(params.data);
			backendService.storePlayer(playerModel.getCurrentPlayer());
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
		}

		public function fetchFriendImages() : void
		{
			loadPictures(); //Test all friends
			// loadTestPlayers(); 
		}

		private function loadTestPlayers() : void
		{
			if (friendIndex < 4)
			{
				showFriend();
			}
		}

		private function showFriend() : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerFriends();

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			loadTestPlayers();
		}

		private function loadPictures() : void
		{
			//playerModel.getPlayerFriends().length
			if (friendIndex < 10)
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicturesListener);
				loader.load(new URLRequest(playerModel.getPlayerFriends()[friendIndex].getPlayerPictureUrl()));
			}
		}

		private function onLoadPicturesListener(event : Event) : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerFriends();
			playerF[friendIndex].setPlayerPicture(Bitmap(loader.content));

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			loadPictures();
		}

		public function inviteFriend() : void
		{
			var dat : Object = new Object();
			dat.message = 'invite';
			dat.title = 'fastclick';
			dat.filters = ['app_non_users'];
			// You can use these two options for diasplaying friends invitation window 'iframe' 'popup'
			Facebook.ui('apprequests', dat, onUICallback, 'iframe');
		}

		private function onUICallback(result : Object) : void
		{
			trace(result.to);
		}
	}
}
