package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class StartClickEvent extends Event
	{
		public static const START_COUNTDOWN:String = "startCountdown";
		
		public function StartClickEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
