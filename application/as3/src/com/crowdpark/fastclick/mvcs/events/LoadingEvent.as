package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class LoadingEvent extends BaseEvent
	{
		public static const CHANGE_STATE : String = "CHANGE_STATE";
		public function LoadingEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = true)
		{
			 super(type,bubbles,cancelable);
		}
	}
}
