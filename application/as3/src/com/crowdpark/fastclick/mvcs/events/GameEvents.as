package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;
	/**
	 * @author fatmatekin
	 */
	public class GameEvents extends BaseEvent
	{
		public static const SHOW_FRIENDS : String = "SHOW_FRIENDS";
		public static const SHOW_FRIEND : String = "SHOW_FRIEND";
		public static const SET_PLAYER_COOKIE : String = "SET_PLAYER_COOKIE";
		
		public function GameEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
