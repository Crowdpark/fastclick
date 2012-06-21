package com.crowdpark.fastclick.mvcs.views.control
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseEvent;

	/**
	 * @author fatmatekin
	 */
	public class ControlViewEvent extends BaseEvent
	{
		public static const SEND_GIFTS : String = 'SEND_GIFTS';
		public static const PLAY : String = "PLAY";
		public static const INVITE_FRIENDS : String = "INVITE_FRIENDS";

		public function ControlViewEvent(type : String, bubble : Boolean = false, cancellable : Boolean = false)
		{
			super(type,bubbles,cancellable);
		}
		
	}
}
