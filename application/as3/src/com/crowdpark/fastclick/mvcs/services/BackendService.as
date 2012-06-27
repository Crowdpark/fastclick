package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.HighestScoreEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.net.rpc.json.JsonRpcClient;
	import com.crowdpark.net.rpc.json.JsonRpcClientEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.external.ExternalInterface;

	/**
	 * @author fatmatekin
	 */
	public class BackendService extends Actor
	{
		[Inject]
		public var configModel : ConfigModel;

		public function storePlayerGetAppFriend(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [{'id':player.getPlayerId(), 'friendsList':player.getFriendsList()}];
			jsonClient.method = 'NoAuth.Player.getAppFriends';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onGetAppFriends);
			jsonClient.send();
		}

		private function onGetAppFriends(event : JsonRpcClientEvent) : void
		{
			var data : Object = new Object();
			data.appFriends = event.getDataprovider().getValueByKey('friends');
			data.user = event.getDataprovider().getValueByKey('user');
			data.gifts = event.getDataprovider().getValueByKey('gifts');

			var backendServiceEvent : BackendServiceEvent = new BackendServiceEvent(BackendServiceEvent.SET_APP_FRIENDS);
			backendServiceEvent.getDataprovider().setValueByKey('data', data);
			dispatch(backendServiceEvent);
		}

		public function getHighestScores(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [{'id':player.getPlayerId()}];
			jsonClient.method = 'NoAuth.Player.getScores';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onHighestScores);
			jsonClient.send();
		}

		private function onHighestScores(event : JsonRpcClientEvent) : void
		{
			var data = event.getDataprovider();

			var leaderboardEvent : HighestScoreEvent = new HighestScoreEvent(HighestScoreEvent.CREATE_HIGHEST_SCORES);
			leaderboardEvent.getDataprovider().setValueByKey('result', data.getValues());
			dispatch(leaderboardEvent);
		}

		public function removeGift(requestId : String, player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [{'id':player.getPlayerId(), 'requestId':requestId}];
			jsonClient.method = 'NoAuth.Game.acceptGift';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onAcceptGift);
			jsonClient.send();
		}

		private function onAcceptGift(event : JsonRpcClientEvent) : void
		{
			
			ExternalInterface.call('crowdparkFlash.facebookAppRequestHandler');
		}

		public function storeResult(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [{'id':player.getPlayerId(), 'currentScore':player.getCurrentScore().getScore(), 'currentLevel':player.getCurrentLevel(), 'selectedLevel':player.getSelectedLevel()}];
			jsonClient.method = 'NoAuth.Player.updateUser';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStoreResults);
			jsonClient.send();
		}

		private function onStoreResults(event : JsonRpcClientEvent) : void
		{
		}

		public function sendGift(playerId, data : Object) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [{'id':playerId, 'recipient_list':data}];
			jsonClient.method = 'NoAuth.Game.sendGift';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onSendGift);
			jsonClient.send();
		}

		private function onSendGift(event : JsonRpcClientEvent) : void
		{
		}
	}
}
