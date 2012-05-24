package com.crowdpark.fastclick.mvcs.core
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineEvents extends Event
	{
		public static const START:String = "startGame";
		public static const GAME:String = "playGame";
		public static const FINISH : String = "finishGame";
		public static const RETRY: String = "retryGame";

		public function StateMachineEvents(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
		 
	}
}
