package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author fatmatekin
	 */
	public class BitmapFetcherService extends Actor
	{
		private var loader : Loader;
		private var currentList : Object;
		private var appImageArray : Array = new Array();
		private var appFriendIndex : uint = 0;

		public function fetchBitMap(url : String) : void
		{
			var loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFetchBitmapListener);
			loader.load(new URLRequest(url));
		}

		public function onFetchBitmapListener(event : Event) : void
		{
			var bfsEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.BITMAP_FETCHED);
			bfsEvent.getDataprovider().setValueByKey('bitmap', event.currentTarget.content);
			dispatch(bfsEvent);
		}

		public function startFetchingBitmaps(friendData : *) : void
		{
			for (var i : uint = 0;i < friendData.length;i++)
			{
				var url : String = 'http://graph.facebook.com/' + friendData[i].id + '/picture';

				fetchBitMap(url);
			}
		}

		public function fetchAppBitmaps(friendData : Object) : void
		{
			currentList = friendData;
			if (appFriendIndex <= friendData.length)
			{
				var url : String = 'http://graph.facebook.com/' + friendData[appFriendIndex].id + '/picture';

				var loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAppBitmapListener);
				loader.load(new URLRequest(url));
			}
		}

		private function onAppBitmapListener(event : Event) : void
		{
			appImageArray.push(event.currentTarget.content);
			if (appImageArray.length == currentList.length)
			{
				var serviceEvent : BitmapFetcherServiceEvent = new BitmapFetcherServiceEvent(BitmapFetcherServiceEvent.APP_FETCHED);
				serviceEvent.getDataprovider().setValueByKey('array', appImageArray);
				dispatch(serviceEvent);
			}
			else
			{
				appFriendIndex++;
				fetchAppBitmaps(currentList);
			}
		}
	}
}
