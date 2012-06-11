package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.system.Security;
	import flash.net.URLRequest;
	import flash.display.Loader;

	import com.facebook.graph.Facebook;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Actor;

	import flash.external.ExternalInterface;

	/**
	 * @author fatmatekin
	 */
	public class FacebookService extends Actor
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendService : BackendService;
		private var friendIndex : uint = 0;
		private var loader : Loader;

		public function init() : void
		{
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");

			registerJSCallbacks();
			Facebook.init('300602210033160');
			ExternalInterface.call("login");
		}

		public function registerJSCallbacks() : void
		{
			ExternalInterface.addCallback("loginFinished", onLoginFinished);
		}

		private function onLoginFinished(params : Object) : void
		{
			Facebook.api("/me", onMe);
		}

		private function onMe(success : Object, error : Object) : void
		{
			playerModel.createPlayer(String(success.first_name), String(success.last_name), uint(success.id));

			Facebook.api('/me/friends', onFetchFriends);
		}

		private function onFetchFriends(success : Object, error : Object) : void
		{
			playerModel.getCurrentPlayer().setFriendsList(success);

			backendService.storePlayer(playerModel.getCurrentPlayer());
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
		}

		public function fetchFriendImages() : void
		{
			loadPictures();
		}

		private function loadPictures() : void
		{
			if (friendIndex < 15)
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicturesListener);
				loader.load(new URLRequest(playerModel.getPlayerFriends()[friendIndex].getPlayerPictureUrl()));
			}
		}

		private function onLoadPicturesListener(event : Event) : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerFriends();
			playerF[friendIndex].setPlayerPicture(loader.content);

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			loadPictures();
		}
	}
}
