package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class BackendServiceEvents extends BaseEvent
	{
		public static const STORE_PLAYER : String = "STORE_PLAYER";
		public static const SAVE_CONFIG_DATA : String = "SAVE_CONFIG_DATA";
		public static const FETCH_ALL_FRIENDS : String = "FETCH_ALL_FRIENDS";
		public function BackendServiceEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
