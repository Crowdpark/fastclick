package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.adobe.serialization.json.JSONDecoder;

	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceConfigService;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class ConfigService extends Actor implements InterfaceConfigService
	{
		private var urlLoader : URLLoader;
		[Inject]
		public var configModel : ConfigModel;

		public function fetchData(url : String) : void
		{
			urlLoader = new URLLoader();
			var urlRequest : URLRequest = new URLRequest(url);
			urlLoader.load(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE, handleComplete);
		}

		private function handleComplete(event : Event) : void
		{
			parseResult(urlLoader.data);
		}

		public function parseResult(result : Object) : void
		{
			var jsonDecoder : JSONDecoder = new JSONDecoder(String(result), true);
			configModel.saveData(jsonDecoder);
		}
	}
}
