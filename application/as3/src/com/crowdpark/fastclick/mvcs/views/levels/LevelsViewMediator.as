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
			var levelArray : Vector.<LevelVo> = configModel.getLevelArray();
			var currentLevel:uint = playerModel.getCurrentPlayer().getCurrentLevel();
			
			if (levelArray)
			{
				showLevels(levelArray,currentLevel);
			}
		}

		override protected function handleReadyToStart(e : StateMachineEvents) : void
		{
			super.handleReadyToStart(e);
			view.enableSelect();
		}

		private function onLevelSelectListener(event : GameEvents) : void
		{
			playerModel.getCurrentPlayer().setSelectedLevel(uint(event.getDataprovider().getValueByKey('selectedLevel')));
			configModel.setGameDuration(configModel.getGameDuration()+uint(event.getDataprovider().getValueByKey('selectedLevelDuration')));
			dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		private function showLevels(levelArray : Vector.<LevelVo>,currentLevel) : void
		{
			view.getDataProvider().setValueByKey('levelArray', levelArray);
			view.createLevels(currentLevel);
			view.enableSelect();
		}

		protected function get view() : LevelsView
		{
			return viewComponent as LevelsView;
		}
	}
}
