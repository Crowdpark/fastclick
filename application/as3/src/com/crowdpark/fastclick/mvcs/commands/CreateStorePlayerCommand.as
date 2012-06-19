package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class CreateStorePlayerCommand extends Command
	{
		
		[Inject]
		public var facebookServiceEvent:FacebookServiceEvent;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var backendService:BackendService;
		
		override public function execute() : void
		{
			var player:PlayerVo = playerModel.createPlayer(String(facebookServiceEvent.getDataprovider().getValueByKey('firstName')), 
			String(facebookServiceEvent.getDataprovider().getValueByKey('lastName')), 
			uint(facebookServiceEvent.getDataprovider().getValueByKey('id')));
			
			backendService.storePlayer(player);
		}
	}
}
