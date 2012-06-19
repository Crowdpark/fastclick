package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
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
		public var configModel : ConfigModel;

		public function storePlayer(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			//jsonClient.params = [player.getValues()];
			jsonClient.params = [{'id':player.getPlayerId(),'friendsList':player.getFriendsList()}];
			jsonClient.method = 'NoAuth.Player.getAppFriends';
			jsonClient.url = configModel.getUrl();
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onGetAppFriends);
			jsonClient.send();
		}

		public function storeResults(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			//jsonClient.params = [player.getValues()];
			jsonClient.params = [{'id':player.getPlayerId(),'curretScore':player.getCurrentScore(),'currentLevel':player.getCurrentLevel()}]; 
			jsonClient.method = 'NoAuth.Player.updateUser';
			jsonClient.url = configModel.getUrl();
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

		private function onGetAppFriends(event : JsonRpcClientEvent) : void
		{
			var allFriends = event.getDataprovider().getValueByKey('friends');
			var user = event.getDataprovider().getValueByKey('user');

			var backendServiceEvent : BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.SET_APP_FRIENDS);
			backendServiceEvent.getDataprovider().setValueByKey('appFriends', allFriends);
			backendServiceEvent.getDataprovider().setValueByKey('user', user);
			dispatch(backendServiceEvent);
		}
	}
}
