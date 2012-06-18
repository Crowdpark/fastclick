package com.crowdpark.fastclick.mvcs.views.levels
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class LevelsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			if (stateMachineModel.state == StateMachineState.RETRY)
			{
				onShowLevelsListener(null);
				view.enableSelect();
			}

			addViewListener(GameEvents.LEVEL_SELECT, onLevelSelectListener);
			addContextListener(GameEvents.SHOW_LEVELS, onShowLevelsListener);
			addContextListener(StateMachineEvents.READY_TO_PLAY, onReadyToPlayListener);
		}

		private function onReadyToPlayListener(event : StateMachineEvents) : void
		{
			view.enableSelect();
		}

		private function onLevelSelectListener(event : GameEvents) : void
		{
			playerModel.getCurrentPlayer().setSelectedLevel(uint(event.getDataprovider().getValueByKey('selectedLevel')));
			configModel.setGameDuration(uint(event.getDataprovider().getValueByKey('selectedLevelDuration')));
			dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		private function onShowLevelsListener(e : GameEvents) : void
		{
			view.getDataProvider().setValueByKey('levelArray', configModel.getLevelArray());
			view.createLevels();
		}

		private function get view() : LevelsView
		{
			return viewComponent as LevelsView;
		}
	}
}
