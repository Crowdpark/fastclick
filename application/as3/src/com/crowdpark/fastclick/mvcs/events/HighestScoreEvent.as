package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class HighestScoreEvent extends BaseEvent
	{
		public static const SHOW_HIGHEST_SCORE : String = "SHOW_HIGHEST_SCORE";
		public static const CREATE_HIGHEST_SCORES : String = "CREATE_HIGHEST_SCORES";
		
		public function HighestScoreEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
