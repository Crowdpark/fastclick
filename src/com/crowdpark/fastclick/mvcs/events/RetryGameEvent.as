package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class RetryGameEvent extends Event
	{
		public static const RETRY_GAME:String = "retryGame";
		public function RetryGameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
