package com.crowdpark.fastclick.mvcs.views.levels
{
	import com.crowdpark.fastclick.mvcs.models.vo.LevelVo;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;

	/**
	 * @author fatmatekin
	 */
	public class LevelsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			if (stateMachineModel.state == StateMachineState.REPLAY)
			{
				view.enableSelect();
			}

			addViewListener(GameEvents.LEVEL_SELECT, onLevelSelectListener);
			// addContextListener(GameEvents.SHOW_LEVELS, onShowLevelsListener);
			var levelArray : Vector.<LevelVo> = configModel.getLevelArray();
			if (levelArray)
			{
				showLevels(levelArray);
			}
		}

		override public function handleReadyToStart(e : StateMachineEvents) : void
		{
			super.handleReadyToStart(e);
			view.enableSelect();
		}

		private function onLevelSelectListener(event : GameEvents) : void
		{
			playerModel.getCurrentPlayer().setSelectedLevel(uint(event.getDataprovider().getValueByKey('selectedLevel')));
			configModel.setGameDuration(uint(event.getDataprovider().getValueByKey('selectedLevelDuration')));
			dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		private function showLevels(levelArray : Vector.<LevelVo>) : void
		{
			view.getDataProvider().setValueByKey('levelArray', levelArray);
			view.createLevels();
			view.enableSelect();
		}

		protected function get view() : LevelsView
		{
			return viewComponent as LevelsView;
		}
	}
}
