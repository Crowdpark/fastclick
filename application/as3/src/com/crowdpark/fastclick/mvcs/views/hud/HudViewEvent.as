package com.crowdpark.fastclick.mvcs.views.hud
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class HudViewEvent extends Event
	{
		public static const UPDATE : String = "UPDATE";
		public function HudViewEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
