package com.crowdpark.fastclick.mvcs.services
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
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
		public var highestScoreModel : HighestScoreModel;

		public function storePlayer(player : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [player.getValues()];
			jsonClient.method = 'NoAuth.Player.saveGame';
			jsonClient.url = 'http://local.fastclick/api/v1/notauth/';
			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStorePointResult);
			jsonClient.send();
		}

		private function onStorePointResult(event : JsonRpcClientEvent) : void
		{
			//var jsonDecoder : JSONDecoder = new JSONDecoder(String(event.getDataprovider()), true);
		}
	}
}
