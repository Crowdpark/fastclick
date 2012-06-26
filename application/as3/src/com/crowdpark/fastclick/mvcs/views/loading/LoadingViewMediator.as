package com.crowdpark.fastclick.mvcs.views.loading
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.LoadingEvent;

	/**
	 * @author fatmatekin
	 */
	public class LoadingViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			
			view.changeLoadingState(loadingModel.getLoadingState());
			
			addContextListener(LoadingEvent.CHANGE_STATE, onStateChangeListener);
			
		}

		private function onStateChangeListener(event:LoadingEvent) : void
		{
			view.changeLoadingState(loadingModel.getLoadingState());
		}

		private function get view() : LoadingView
		{
			return viewComponent as LoadingView;
		}
	}
}
