package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;
	
	/**
	 * @author fatmatekin
	 */
	public class PointClickEvent extends BaseEvent
	{
		public static const POINT_CLICK : String = "POINT_CLICK";
		public static const POINT_TWEEN:String ="POINT_TWEEN";
		public function PointClickEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
	}
}
