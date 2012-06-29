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
		public static const BEAT_FRIEND : String = "BEAT_FRIEND";
		public static const SHARE_BEAT_FRIEND : String = "SHARE_BEAT_FRIEND";
		public static const REFRESH_LEADERBOARD : String = "REFRESH_LEADERBOARD";
		public static const SCORE_SHARED : String = "SCORE_SHARED";

		public function LeaderboardEvent(type : String, bubbles : Boolean = false, cancellable : Boolean = true)
		{
			super(type, bubbles, cancellable);
		}
	}
}
