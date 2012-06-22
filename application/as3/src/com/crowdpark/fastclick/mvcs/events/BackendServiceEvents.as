package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class BackendServiceEvents extends BaseEvent
	{
		public static const SAVE_CONFIG_DATA : String = "SAVE_CONFIG_DATA";
		public static const SET_APP_FRIENDS : String = "SET_APP_FRIENDS";
		public static const START_FETCH_FRIENDS : String = "START_FETCH_FRIENDS";
		public static const SEND_GIFT_BACKEND : String = "SEND_GIFT_BACKEND";

		public function BackendServiceEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
