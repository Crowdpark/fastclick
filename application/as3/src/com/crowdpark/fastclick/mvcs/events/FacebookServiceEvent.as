package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class FacebookServiceEvent extends BaseEvent
	{
		public static const SET_USER : String = "SET_USER";
		public static const FETCH_FRIENDS_IMAGES : String = "FETCH_FRIENDS_IMAGES";
		public static const LOG_OUT : String = "LOG_OUT";
		public static const INVITE_FRIEND : String = "INVITE_FRIEND";
		public static const FETCH_APP_FRIENDS_IMAGES : String = "FETCH_APP_FRIENDS_IMAGES";

		public function FacebookServiceEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
