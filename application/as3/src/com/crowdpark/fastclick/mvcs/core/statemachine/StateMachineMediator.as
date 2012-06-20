package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineMediator extends Mediator
	{
		[Inject]
		public var stateMachineModel : StateMachineModel;
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var configModel : ConfigModel;
		[Inject]
		public var highestScoreModel : HighestScoreModel;

		override public function onRegister() : void
		{
			addContextListener(StateMachineEvents.START, handleStart);
			addContextListener(StateMachineEvents.GAME, handleGame);
			addContextListener(StateMachineEvents.FINISH, handleFinish);
			addContextListener(StateMachineEvents.REPLAY, handleReplay);
			addContextListener(StateMachineEvents.READY_TO_START, handleReadyToStart);
			addContextListener(StateMachineEvents.LOADING, handleLoading);
		}

		protected function handleReplay(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.REPLAY;
		}

		protected function handleLoading(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.LOADING;
		}

		protected function handleStart(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.START;
		}

		protected function handleGame(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.GAME;
		}

		protected function handleFinish(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.FINISH;
		}

		public function handleReadyToStart(e : StateMachineEvents) : void
		{
			stateMachineModel.state = StateMachineState.READY_TO_PLAY;
		}
	}
}
