package com.crowdpark.fastclick.mvcs.views.control
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class ControlViewEvent extends BaseEvent
	{
		public static const INVITE_FRIENDS : String = "INVITE_FRIENDS";
		public static const SHOW_LOBBY : String = "SHOW_LOBBY";

		public function ControlViewEvent(type : String, bubbles : Boolean = false, cancellable : Boolean = false)
		{
			super(type, bubbles, cancellable);
		}
	}
}
