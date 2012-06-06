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

		public function LeaderboardEvent(type : String, bubbles : Boolean = false, cancellable : Boolean = true)
		{
			super(type, bubbles, cancellable);
		}
	}
}
