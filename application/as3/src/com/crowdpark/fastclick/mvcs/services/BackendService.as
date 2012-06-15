package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.net.rpc.json.JsonRpcClient;
	import com.crowdpark.net.rpc.json.JsonRpcClientEvent;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class BackendService extends Actor
	{
		[Inject]
		public var playerModel : PlayerModel;

		public function storePlayer(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [player.getValues()];
			jsonClient.method = 'NoAuth.Player.getAppFriends';
			jsonClient.url = 'http://dev-fastclick.crowdpark-cloud.com/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStorePointResult);
			jsonClient.send();
		}

		public function storeResults(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [player.getValues()];
			jsonClient.method = 'NoAuth.Player.updateUser';
			jsonClient.url = 'http://dev-fastclick.crowdpark-cloud.com/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStoreResults);
			jsonClient.send();
		}

		private function onStoreResults(event : JsonRpcClientEvent) : void
		{
			var data = event.getDataprovider();

			var leaderboardEvent : LeaderboardEvent = new LeaderboardEvent(LeaderboardEvent.SHOW_HIGHEST_SCORE);
			leaderboardEvent.getDataprovider().setValueByKey('result', data.getValues());
			dispatch(leaderboardEvent);
		}

		private function onStorePointResult(event : JsonRpcClientEvent) : void
		{
			var allFriends = event.getDataprovider().getValueByKey('friends');
			var user = event.getDataprovider().getValueByKey('user');

			var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.FETCH_ALL_FRIENDS);
			backendServiceEvent.getDataprovider().setValueByKey('allFriends', allFriends);
			backendServiceEvent.getDataprovider().setValueByKey('user', user);
			dispatch(backendServiceEvent);
		}
	}
}
