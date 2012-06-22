package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class GiftEvent extends BaseEvent
	{
		public static const SEND_GIFT : String = "SEND_GIFT";
		public static const SHOW_GIFT : String = "SHOW_GIFT";
		public static const ADD_GIFT : String = "ADD_GIFT";
		public function GiftEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
