package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;

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
			if (stateMachineModel.getGameState() == StateMachineState.REPLAYED || stateMachineModel.state == StateMachineState.LOBBY) ;
			{
				handleReadyToStart(null);
				onShowGiftListener(null);
			}

			addViewListener(StartView.PLAY_GAME, onPlayGameListener);
			addViewListener(StartView.RECEIVE_GIFT, onReceiveGiftListener);

			addContextListener(GameEvents.SET_PLAYER_COOKIE, setPlayerListener);
			addContextListener(GiftEvent.SHOW_GIFT, onShowGiftListener);
		}

		private function onReceiveGiftListener(event : Event) : void
		{
			var receivedGift = view.getDataProvider().getValueByKey('receivedGift');
			var receivedgiftType = view.getDataProvider().getValueByKey('giftType');

			var giftEvent : GiftEvent = new GiftEvent(GiftEvent.ADD_GIFT);
			giftEvent.getDataprovider().setValueByKey('receivedGift', receivedGift);
			giftEvent.getDataprovider().setValueByKey('giftType', receivedgiftType);
			dispatch(giftEvent);
		}

		private function onShowGiftListener(event : GiftEvent) : void
		{
			view.getDataProvider().setValueByKey('receivedGiftList', giftModel.getReceivedGiftList());
			view.getDataProvider().setValueByKey('giftVariety', giftModel.getGiftVariety());
			view.showGifts();
		}

		private function onPlayGameListener(e : Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.PLAY_GAME));
		}

		override protected function handleReadyToStart(e : StateMachineEvents) : void
		{
			super.handleReadyToStart(e);
			if (loadingModel.getLoadingState() == 'logged in')
			{
				view.addStartButton();
			}
			else
			{
				addContextListener(FacebookServiceEvent.CREATE_PLAYER, showPlayerButtonListener);
			}
		}

		private function showPlayerButtonListener(event : FacebookServiceEvent) : void
		{
			view.addStartButton();
		}

		private function setPlayerListener(event : GameEvents) : void
		{
			view.updatePlayerNameField(String(event.getDataprovider().getValueByKey('playerName')), String(event.getDataprovider().getValueByKey('playerLastName')));
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
