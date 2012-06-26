package com.crowdpark.fastclick.mvcs.services
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceConfigService;

	import org.robotlegs.mvcs.Actor;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author fatmatekin
	 */
	public class ConfigService extends Actor implements InterfaceConfigService
	{
		private var urlLoader : URLLoader;
		
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

			var backendServiceEvent : BackendServiceEvent = new BackendServiceEvent(BackendServiceEvent.SAVE_CONFIG_DATA);
			backendServiceEvent.getDataprovider().setValueByKey('jsonData', jsonDecoder);
			dispatch(backendServiceEvent);			
		}
	}
}
