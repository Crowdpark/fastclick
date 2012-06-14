package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;
	/**
	 * @author fatmatekin
	 */
	public class GameEvents extends BaseEvent
	{
		public static const SHOW_FRIEND : String = "SHOW_FRIEND";
		public static const SET_PLAYER_COOKIE : String = "SET_PLAYER_COOKIE";
		public static const SHOW_LEVELS : String = "SHOW_LEVELS";
		public static const LEVEL_SELECT : String = "LEVEL_SELECT";
		public static const APP_FRIENDS_LOADED : String = "APP_FRIENDS_LOADED";
		public static const FRIENDS_LOADED : String = "FRIENDS_LOADED";
		
		public function GameEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
