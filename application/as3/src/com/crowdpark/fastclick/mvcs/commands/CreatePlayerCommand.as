package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class CreatePlayerCommand extends Command
	{
		
		[Inject]
		public var facebookServiceEvent:FacebookServiceEvent;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute() : void
		{
			playerModel.createPlayer(String(facebookServiceEvent.getDataprovider().getValueByKey('firstName')), 
			String(facebookServiceEvent.getDataprovider().getValueByKey('lastName')), 
			uint(facebookServiceEvent.getDataprovider().getValueByKey('id')));
		}
	}
}
