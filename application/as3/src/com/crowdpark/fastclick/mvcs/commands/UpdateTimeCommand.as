package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class UpdateTimeCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;

		override public function execute() : void
		{
			configModel.updateTimer();
		}
	}
}
