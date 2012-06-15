package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.facebook.graph.Facebook;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.external.ExternalInterface;
	import flash.system.Security;

	/**
	 * @author fatmatekin
	 */
	public class FacebookService extends Actor
	{
		[Inject]
		public var playerModel : PlayerModel;
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
			var facebookServiceEvent : FacebookServiceEvent = new FacebookServiceEvent(FacebookServiceEvent.CREATE_PLAYER);
			facebookServiceEvent.getDataprovider().setValueByKey('firstName', String(params.first_name));
			facebookServiceEvent.getDataprovider().setValueByKey('lastName', String(params.last_name));
			facebookServiceEvent.getDataprovider().setValueByKey('id', String(params.id));
			dispatch(facebookServiceEvent);

			// playerModel.createPlayer(String(params.first_name), String(params.last_name), uint(params.id));
		}

		private function onFetchFriends(params : Object) : void
		{
			// playerModel.getCurrentPlayer().setFriendsList(params.data);

			var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.STORE_PLAYER);
			backendServiceEvent.getDataprovider().setValueByKey('data', params.data);
			dispatch(backendServiceEvent);
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
		}

		public function fetchFriendImages() : void
		{
			loadPictures(playerModel.getPlayerFriends());
		}

		private function loadPictures(friendArray : Vector.<PlayerVo>) : void
		{
			if (friendIndex < friendArray.length)
			{
				var bitmapServiceEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.LOAD_BITMAP);
				bitmapServiceEvent.getDataprovider().setValueByKey('friendIndex', friendIndex);
				dispatch(bitmapServiceEvent);
			}
			else
			{
				dispatch(new StateMachineEvents(StateMachineEvents.READY_TO_PLAY));
			}
		}

		public function addLoadedBitmap(bitmap : Bitmap) : void
		{
			var playerF : Vector.<PlayerVo> = playerModel.getPlayerFriends();
			playerF[friendIndex].setPlayerPicture(bitmap);

			var gameEvent : GameEvents = new GameEvents(GameEvents.SHOW_FRIEND);
			gameEvent.getDataprovider().setValueByKey('currentFriend', playerF[friendIndex]);
			dispatch(gameEvent);

			friendIndex++;
			loadPictures(playerF);
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

		public function readyToPlay() : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.READY_TO_PLAY));
		}
	}
}
