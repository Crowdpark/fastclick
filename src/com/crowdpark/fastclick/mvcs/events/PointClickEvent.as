package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class PointClickEvent extends Event
	{
		public static const POINT_CLICK:String = "pointClick";
		public function PointClickEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
