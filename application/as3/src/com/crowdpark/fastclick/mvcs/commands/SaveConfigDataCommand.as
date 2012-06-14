package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SaveConfigDataCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;
		
		[Inject]
		public var backendServiceEvent : BackendServiceEvents; 
		
		override public function execute() : void
		{
			var data = backendServiceEvent.getDataprovider().getValueByKey('jsonData');
			configModel.saveData(data);
		}
	}
}
