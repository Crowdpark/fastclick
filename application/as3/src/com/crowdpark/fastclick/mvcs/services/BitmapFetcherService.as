package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;

	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class BitmapFetcherService extends Actor
	{
		private var loader : Loader;

		public function fetchBitMap(url : String) : void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFetchBitmapListener);
			loader.load(new URLRequest(url));
		}

		public function onFetchBitmapListener(event : Event) : void
		{
			var bfsEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.BITMAP_FETCHED);
			bfsEvent.getDataprovider().setValueByKey('bitmap', loader.content);
			dispatch(bfsEvent);
		}
	}
}
