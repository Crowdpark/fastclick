package com.crowdpark.fastclick.mvcs.views
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
		}

		private function get view() : GameView
		{
			return viewComponent as GameView;
		}
	}
}
