package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class GameEvents extends Event
	{
		public static const SET_PLAYER : String = "SET_PLAYER";
		public var playerName : String;

		public function GameEvents(type : String, player : String) : void
		{
			this.playerName = player;
			super(type, false, false);
		}

		override public function clone() : Event
		{
			return new GameEvents(type, playerName);
		}
	}
}
