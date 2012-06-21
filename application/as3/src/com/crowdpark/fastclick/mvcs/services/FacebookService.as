package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.facebook.graph.Facebook;

	import org.robotlegs.mvcs.Actor;

	import flash.external.ExternalInterface;
	import flash.system.Security;

	/**
	 * @author fatmatekin
	 */
	public class FacebookService extends Actor
	{
		var currentObject : GiftVo;

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
			var facebookServiceEvent : FacebookServiceEvent = new FacebookServiceEvent(FacebookServiceEvent.CREATE_STORE_PLAYER);
			facebookServiceEvent.getDataprovider().setValueByKey('firstName', String(params.first_name));
			facebookServiceEvent.getDataprovider().setValueByKey('lastName', String(params.last_name));
			facebookServiceEvent.getDataprovider().setValueByKey('id', String(params.id));
			dispatch(facebookServiceEvent);
		}

		private function onFetchFriends(params : Object) : void
		{
			var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.START_FETCH_FRIENDS);
			backendServiceEvent.getDataprovider().setValueByKey('data', params.data);
			dispatch(backendServiceEvent);
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
		}

		public function inviteFriend() : void
		{
			/*var dat : Object = new Object();
			dat.message = 'invite';
			dat.title = 'fastclick';
			dat.filters = ['app_non_users'];
			Facebook.ui('apprequests', dat, onUICallback, 'iframe');*/

			var data = new Object();
			data.id = 100003894794078;
			data.trackingUid = 100003894794078;

			ExternalInterface.call('crowdparkFlash.facebookInviteFriends', data);
		}

		private function facebookInviteFriends(result : Object) : void
		{
		}

		private function onUICallback(result : Object) : void
		{
		}

		public function sendGift(gift : GiftVo) : void
		{
			var data = new Object();
			data.message = 'test gift send';
			data.type = 1;
			data.amount = 10;
			if (gift)
			{
				currentObject = gift;
				data.uid = gift.getFriendId();
			}

			ExternalInterface.call('crowdparkFlash.facebookSendGift', data);
			ExternalInterface.addCallback('facebookSendGift', facebookSendGift);
		}

		private function facebookSendGift(result : Object) : void
		{
			if (result != 0)
			{
				currentObject.setRequest(String(result));

				var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.SEND_GIFT);
				backendServiceEvent.getDataprovider().setValueByKey('data', currentObject);
				dispatch(backendServiceEvent);
			}
		}
	}
}
