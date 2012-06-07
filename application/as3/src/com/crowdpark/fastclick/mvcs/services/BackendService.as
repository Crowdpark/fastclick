package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.net.rpc.json.JsonRpcClientEvent;
	import com.crowdpark.net.rpc.json.JsonRpcClient;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class BackendService extends Actor
	{
		public function storePoints(point : PlayerVo) : void
		{
			var jsonClient : JsonRpcClient = new JsonRpcClient();
			jsonClient.params = [point.getValues()];
			jsonClient.method = 'App.';
			jsonClient.url = '';

			jsonClient.addEventListener(JsonRpcClientEvent.RESULT, onStorePointResult);
		}

		private function onStorePointResult(event : JsonRpcClientEvent) : void
		{
		}
	}
}
