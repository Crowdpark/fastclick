package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class UpdateTimeCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			playerModel.updateTimer();
		}
	}
}
