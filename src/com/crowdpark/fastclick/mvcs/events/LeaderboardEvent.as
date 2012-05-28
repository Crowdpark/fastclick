package com.crowdpark.fastclick.mvcs.events
{
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardEvent extends Event
	{
		public static const SORT : String = "SORT";
		public static const SET_NAME : String = "SET_NAME";
		public var playerName:String;
	
		public function LeaderboardEvent(type : String, playerName : String)
		{
			this.playerName = playerName;
			super(type,false,false);
		}

		override public function clone() : Event
		{
			return new LeaderboardEvent(type, playerName);
		}

	}
}
