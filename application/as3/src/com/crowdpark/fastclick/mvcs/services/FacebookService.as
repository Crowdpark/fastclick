package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
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
		public var bitmapService : BitmapLoaderService;
		private var friendIndex : uint = 0;
		private var loader : Loader;

		public function init() : void
		{
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
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
			playerModel.getCurrentPlayer().setFriendsList(params.data);
			
			backendService.storePlayer(playerModel.getCurrentPlayer());
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
		}

		public function fetchFriendImages() : void
		{
			loadPictures(playerModel.getPlayerFriends());
		}

		public function fetchAppFriendImages() : void
		{
			var friendArray : Vector.<PlayerVo> = playerModel.getPlayerAppFriends();
			if (friendArray.length > 0)
			{
				loadPictures(friendArray);
			}
		}

		private function loadPictures(friendArray : Vector.<PlayerVo>) : void
		{
			if (friendIndex < friendArray.length)
			{
				bitmapService.fetchBitMap(friendArray[friendIndex].getPlayerPictureUrl());
			}
			else
			{
				dispatch(new GameEvents(GameEvents.APP_FRIENDS_LOADED));
			}

			/*if (friendIndex < 1)
			{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicturesListener);
			loader.load(new URLRequest(friendArray[friendIndex].getPlayerPictureUrl()));
			}*/
		}

		public function addLoadedBitmap(bitmap : Bitmap) : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerAppFriends();
			playerF[friendIndex].setPlayerPicture(bitmap);

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			loadPictures(playerF);
		}

		private function onLoadPicturesListener(event : Event) : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerAppFriends();
			playerF[friendIndex].setPlayerPicture(Bitmap(loader.content));

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			// loadPictures();
		}

		public function inviteFriend() : void
		{
			var dat : Object = new Object();
			dat.message = 'invite';
			dat.title = 'fastclick';
			dat.filters = ['app_non_users'];

			Facebook.ui('apprequests', dat, onUICallback, 'iframe');
		}

		private function onUICallback(result : Object) : void
		{
			trace(result.to);
		}
	}
}
