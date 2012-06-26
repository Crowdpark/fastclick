package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SaveConfigDataCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;
		[Inject]
		public var backendServiceEvent : BackendServiceEvent;

		override public function execute() : void
		{
			var data = backendServiceEvent.getDataprovider().getValueByKey('jsonData');
			configModel.saveData(data);
		}
	}
}
