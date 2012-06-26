package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.LoadingEvent;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class LoadingModel extends Actor
	{
		private var _loadingState : String;

		public function getLoadingState() : String
		{
			return _loadingState;
		}

		public function setLoadingState(loadingState : String) : void
		{
			this._loadingState = loadingState;
			dispatch(new LoadingEvent(LoadingEvent.CHANGE_STATE));
			
		}
	}
}
