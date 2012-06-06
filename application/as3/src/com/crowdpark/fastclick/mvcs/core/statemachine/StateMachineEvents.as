package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;
	
	/**
	 * @author fatmatekin
	 */
	public class StateMachineEvents extends BaseEvent
	{
		public static const START:String = "startGame";
		public static const GAME:String = "playGame";
		public static const FINISH : String = "finishGame";
		public static const RETRY: String = "retryGame";

		public function StateMachineEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type,bubbles,cancelable);
		}
		 
	}
}
