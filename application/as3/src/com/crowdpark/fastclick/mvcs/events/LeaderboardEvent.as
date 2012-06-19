package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardEvent extends BaseEvent
	{
		public static const SORT : String = "SORT";
		public static const SET_NAME : String = "SET_NAME";
		public static const SHOW_HIGHEST_SCORE : String = "SHOW_HIGHEST_SCORE";
		public static const CREATE_HIGHEST_SCORES : String = "CREATE_HIGHEST_SCORES";

		public function LeaderboardEvent(type : String, bubbles : Boolean = false, cancellable : Boolean = true)
		{
			super(type, bubbles, cancellable);
		}
	}
}
