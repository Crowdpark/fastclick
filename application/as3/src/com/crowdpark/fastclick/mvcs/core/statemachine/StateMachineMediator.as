package com.crowdpark.fastclick.mvcs.core.statemachine
{
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
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
			addContextListener(StateMachineEvents.RETRY, handleRetry);
			addContextListener(StateMachineEvents.READY_TO_PLAY, handleReady);
		}

		protected function handleRetry(e : StateMachineEvents) : void
		{
			removeContextListener(StateMachineEvents.RETRY, handleRetry);
			stateMachineModel.state = StateMachineState.RETRY;
		}

		protected function handleStart(e : StateMachineEvents) : void
		{
			removeContextListener(StateMachineEvents.START, handleStart);
			stateMachineModel.state = StateMachineState.START;
		}

		protected function handleGame(e : StateMachineEvents) : void
		{
			removeContextListener(StateMachineEvents.GAME, handleGame);
			stateMachineModel.state = StateMachineState.GAME;
		}

		protected function handleFinish(e : StateMachineEvents) : void
		{
			removeContextListener(StateMachineEvents.FINISH, handleFinish);
			stateMachineModel.state = StateMachineState.FINISH;
		}

		public function handleReady(e : StateMachineEvents) : void
		{
			removeContextListener(StateMachineEvents.READY_TO_PLAY, handleRetry);
			stateMachineModel.state = StateMachineState.READY_TO_PLAY;
		}
	}
}
