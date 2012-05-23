package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class FinishGameEvent extends Event
	{
		public static const FINISH:String = "finishGame";
		public function FinishGameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
