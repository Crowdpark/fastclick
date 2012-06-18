package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.facebook.graph.Facebook;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.external.ExternalInterface;
	import flash.system.Security;

	/**
	 * @author fatmatekin
	 */
	public class FacebookService extends Actor
	{
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
		}

		private function onFetchFriends(params : Object) : void
		{
			var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.STORE_PLAYER);
			backendServiceEvent.getDataprovider().setValueByKey('data', params.data);
			dispatch(backendServiceEvent);
		}

		public function handleLogin(response : Object, fail : Object) : void
		{
			trace('response');
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
