package com.crowdpark.fastclick.mvcs.views.game
{
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class GameViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			
			view.leaderboardView.y = view.hudView.height;
		}

		private function get view() : GameView
		{
			return viewComponent as GameView;
		}
	}
}
