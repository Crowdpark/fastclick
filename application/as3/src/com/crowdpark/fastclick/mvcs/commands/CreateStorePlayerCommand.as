package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class CreateStorePlayerCommand extends Command
	{
		[Inject]
		public var facebookServiceEvent : FacebookServiceEvent;
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			playerModel.createPlayer(String(facebookServiceEvent.getDataprovider().getValueByKey('firstName')), String(facebookServiceEvent.getDataprovider().getValueByKey('lastName')), String(facebookServiceEvent.getDataprovider().getValueByKey('id')));
		}
	}
}
