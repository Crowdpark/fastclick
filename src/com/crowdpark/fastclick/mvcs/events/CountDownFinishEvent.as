package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class CountDownFinishEvent extends Event
	{
		public static const COUNTDOWN_FINISH:String = "countdownFinish";
		
		public function CountDownFinishEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
