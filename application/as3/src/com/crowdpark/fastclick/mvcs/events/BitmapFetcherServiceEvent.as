package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class BitmapFetcherServiceEvent extends BaseEvent
	{
		public static const FETCH_BITMAP : String = "FETCH_BITMAP";
		public static const BITMAP_FETCHED : String = "BITMAP_FETCHED";
		
		public function BitmapFetcherServiceEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
