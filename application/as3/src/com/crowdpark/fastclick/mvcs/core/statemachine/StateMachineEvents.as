package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineEvents extends BaseEvent
	{
		public static const START : String = "START";
		public static const GAME : String = "GAME";
		public static const FINISH : String = "FINISH";
		public static const LOADING : String = "LOADING";
		public static const READY_TO_START : String = "READY_TO_START";
		public static const REPLAYED : String = "REPLAYED";
		public static const REPLAY : String = "REPLAY";
		public static const PLAY_GAME : String = "PLAY_GAME";
		public static const LOBBY : String = "LOBBY";

		public function StateMachineEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
