package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;
	/**
	 * @author fatmatekin
	 */
	public class GameEvents extends BaseEvent
	{
		public static const SET_PLAYER : String = "SET_PLAYER";

		public function GameEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
