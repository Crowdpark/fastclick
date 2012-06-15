package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class BitmapLoaderServiceEvent extends BaseEvent
	{
		public static const BITMAP_LOADED : String = "BITMAP_LOADED";
		public static const LOAD_BITMAP : String = "LOAD_BITMAP";
		public function BitmapLoaderServiceEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
