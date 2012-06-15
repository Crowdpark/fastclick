package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class FastClickBallEvent extends BaseEvent
	{
		public static const REMOVE_CIRCLE : String = "REMOVE_CIRCLE";
		public function FastClickBallEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
	
}
