package com.crowdpark.fastclick.mvcs.services
{
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
		// [Inject]
		// public var highestScoreModel : HighestScoreModel;
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

			// playerModel.setFriendsList();
		}
		public function storeResults(player:PlayerVo) : void
		{
			/*var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [player.getValues()];
			jsonClient.method = 'NoAuth.Player.getAppFriends';
			jsonClient.url = 'http://local.fastclick.com/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStorePointResult);
			jsonClient.send();
			*/
		}

		private function onStorePointResult(event : JsonRpcClientEvent) : void
		{
			var data : InterfaceVO = event.getDataprovider();

			var appFriends = event.getDataprovider().getValueByKey('appfriends');
			var user = event.getDataprovider().getValueByKey('user');

			playerModel.setCurrentLevel(user);
			playerModel.setApplicationFriends(appFriends);
		}
	}
}
