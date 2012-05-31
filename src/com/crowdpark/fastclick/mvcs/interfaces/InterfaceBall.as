package com.crowdpark.fastclick.mvcs.interfaces
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public interface InterfaceBall extends IEventDispatcher
	{
		function getColor() : uint;

		function getEndPoint() : Point;

		function getStartPoint() : Point;

		function getScore() : uint;

	}
}
