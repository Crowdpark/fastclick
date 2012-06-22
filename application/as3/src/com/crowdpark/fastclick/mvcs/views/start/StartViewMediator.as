package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.y = 50;

			if (playerModel.getCurrentPlayer().getPlayerName() != "null")
			{
				view.updatePlayerNameField(playerModel.getCurrentPlayer().getPlayerName(), playerModel.getCurrentPlayer().getPlayerLastName());
			}
			if (stateMachineModel.getGameState() == StateMachineState.REPLAYED)
			{
				// view.removeLoading();
				handleReadyToStart(null);
				onShowGiftListener(null);
			}

			addViewListener(StartView.START_GAME, onStartGameListener);
			addViewListener(StartView.PLAY_GAME, onPlayGameListener);
			addViewListener(StartView.RECEIVE_GIFT, onReceiveGiftListener);
	
			addContextListener(GameEvents.SET_PLAYER_COOKIE, setPlayerListener);
			addContextListener(GiftEvent.SHOW_GIFT, onShowGiftListener);
		}

		private function onReceiveGiftListener(event:Event) : void
		{
			var receivedGift = view.getDataProvider().getValueByKey('receivedGift');
			var giftEvent:GiftEvent = new GiftEvent(GiftEvent.ADD_GIFT);
			giftEvent.getDataprovider().setValueByKey('receivedGift', receivedGift);
			
			dispatch(giftEvent);
		}

		private function onShowGiftListener(event : GiftEvent) : void
		{
			
			view.getDataProvider().setValueByKey('gift', giftModel.getReceivedGiftList());
			view.showGifts();
		}

		private function onPlayGameListener(e : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.PLAY_GAME));
		}

		override public function handleReadyToStart(e : StateMachineEvents) : void
		{
			super.handleReadyToStart(e);
			view.removeLoading();
			view.addStartButton();
		}

		private function setPlayerListener(event : GameEvents) : void
		{
			view.updatePlayerNameField(String(event.getDataprovider().getValueByKey('playerName')), String(event.getDataprovider().getValueByKey('playerLastName')));
		}

		private function onStartGameListener(e : Event) : void
		{
			// dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		protected function get view() : StartView
		{
			return viewComponent as StartView;
		}

		override protected function handleStart(e : StateMachineEvents) : void
		{
			super.handleStart(e);
		}
	}
}
