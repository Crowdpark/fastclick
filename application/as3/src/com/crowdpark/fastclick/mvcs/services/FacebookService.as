package com.crowdpark.fastclick.mvcs.services
{
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
		private var friendIndex : uint = 0;
		private var loader : Loader;

		public function init() : void
		{
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
