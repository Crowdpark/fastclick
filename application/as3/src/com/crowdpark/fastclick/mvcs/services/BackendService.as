package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
	import com.adobe.serialization.json.JSONDecoder;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.net.rpc.json.JsonRpcClientEvent;
	import com.crowdpark.net.rpc.json.JsonRpcClient;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

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
			jsonClient.url = 'http://local.fastclick.com/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStorePointResult);
			jsonClient.send();

		}

		public function storeResults(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [player.getValues()];
			jsonClient.method = 'NoAuth.Player.updateUser';
			jsonClient.url = 'http://local.fastclick.com/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStoreResults);
			jsonClient.send();
		}

		private function onStoreResults(event : JsonRpcClientEvent) : void
		{
			
		}

		private function onStorePointResult(event : JsonRpcClientEvent) : void
		{
			var data : InterfaceVO = event.getDataprovider();

			var appFriends = event.getDataprovider().getValueByKey('appfriends');
			var user = event.getDataprovider().getValueByKey('user');
			
			var backendServiceEvent:BackendServiceEvents = new BackendServiceEvents(BackendServiceEvents.FETCH_ALL_FRIENDS);
			backendServiceEvent.getDataprovider().setValueByKey('allFriends', appFriends);
			backendServiceEvent.getDataprovider().setValueByKey('user', user);
			dispatch(backendServiceEvent);
			
			
		}
	}
}
