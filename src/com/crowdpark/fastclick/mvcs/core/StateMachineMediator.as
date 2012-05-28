package com.crowdpark.fastclick.mvcs.core
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class StateMachineMediator extends Mediator
	{
		[Inject]
		public var stateMachineModel:StateMachineModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function onRegister() : void
		{
			addContextListener(StateMachineEvents.START, handleStart);
			addContextListener(StateMachineEvents.GAME, handleGame);
			addContextListener(StateMachineEvents.FINISH, handleFinish);
			addContextListener(StateMachineEvents.RETRY, handleRetry);
		}

		private function handleRetry() : void
		{
			removeContextListener(StateMachineEvents.START, handleStart);
			stateMachineModel.state = "retry";
		}

		protected function handleStart(e:Event) : void
		{
			removeContextListener(StateMachineEvents.START, handleStart);
			playerModel.setScore(0);
			stateMachineModel.state = "start";
		}

		protected function handleGame(e:Event) : void
		{
			removeContextListener(StateMachineEvents.GAME, handleGame);
			stateMachineModel.state = "game";
		}

		protected function handleFinish(e:Event) : void
		{
			removeContextListener(StateMachineEvents.FINISH, handleFinish);			
			stateMachineModel.state = "finish";
		}
	}
}
