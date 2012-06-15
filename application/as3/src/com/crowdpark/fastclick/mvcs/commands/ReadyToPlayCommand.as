package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ReadyToPlayCommand extends Command
	{
		[Inject]
		public var stateMachineModel : StateMachineModel;
		
		override public function execute() : void
		{
			stateMachineModel.state = StateMachineState.READY_TO_PLAY;	
		}
	}
}
