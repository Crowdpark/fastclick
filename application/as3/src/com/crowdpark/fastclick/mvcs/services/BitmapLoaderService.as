package com.crowdpark.fastclick.mvcs.services
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.events.BitmapLoaderServiceEvent;

	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class BitmapLoaderService extends Actor
	{
		private static const BITMAP_LOADED : String = "BITMAP_LOADED";
		private var _resultBitmap : Bitmap;
		private var loader : Loader;
		private var bitmapIndex : uint = 0;

		public function fetchBitMap(url : String) : void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFetchBitmapListener);
			loader.load(new URLRequest(url));
		}

		private function onFetchBitmapListener(event : Event) : void
		{
			setResultBitmap(Bitmap(loader.content));

			var blsEvent : BitmapLoaderServiceEvent = new BitmapLoaderServiceEvent(BitmapLoaderServiceEvent.BITMAP_LOADED);
			blsEvent.getDataprovider().setValueByKey('bitmap', loader.content);
			dispatch(blsEvent);
		}

		public function getResultBitmap() : Bitmap
		{
			return _resultBitmap;
		}

		public function setResultBitmap(resultBitmap : Bitmap) : BitmapLoaderService
		{
			this._resultBitmap = resultBitmap;
			return this;
		}
	}
}
