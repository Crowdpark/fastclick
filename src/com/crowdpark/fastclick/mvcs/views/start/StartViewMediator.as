package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.net.SharedObject;

	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;

	import flash.events.MouseEvent;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			view.gameTitleSprite.x = (contextView.stage.stageWidth - view.gameTitleSprite.width) / 2;
			view.gameTitleSprite.y = 30;

			view.playerNameSprite.x = (contextView.stage.stageWidth - view.playerNameSprite.width) / 2;
			view.playerNameSprite.y = view.gameTitleSprite.y + view.gameTitleSprite.height + 20;

			view.startButtonSprite.y = 300;
			view.startButtonSprite.x = (contextView.stage.stageWidth - view.startButtonSprite.width) / 2;
			view.startButtonSprite.buttonMode = true;

			eventMap.mapListener(view.startButtonSprite, MouseEvent.CLICK, handleStartClickEvent);

			var flashCookie : SharedObject = SharedObject(playerModel.getFlashCookie());

			if (flashCookie.data.playername)
			{
				view.playerNameField.text = flashCookie.data.playername;
			}
		}

		protected function get view() : StartView
		{
			return viewComponent as StartView;
		}

		private function handleStartClickEvent(e : MouseEvent) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.START));
			dispatch(new GameEvents(GameEvents.SET_PLAYER, view.playerNameField.text));
		}

		override protected function handleStart(e : StateMachineEvents) : void
		{
			super.handleStart(e);
		}
	}
}
