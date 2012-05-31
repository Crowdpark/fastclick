package com.crowdpark.fastclick.mvcs.events
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class PointClickEvent extends Event
	{
		public static const POINT_CLICK : String = "POINT_CLICK";
		public static const POINT_TWEEN:String ="POINT_TWEEN";
		
		public var ball : InterfaceBall;
		public var scoreBox: InterfaceBall;
		
		public function PointClickEvent(type : String, ball : InterfaceBall, scoreBox: InterfaceBall)
		{
			this.ball = ball;
			this.scoreBox = scoreBox;
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event
		{
			return new PointClickEvent(type, ball,scoreBox);
		}
	}
}
