package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ShareBeatCommand extends Command
	{
		[Inject]
		public var facebookService:FacebookService;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute() : void
		{
				facebookService.facebookShareScore(playerModel.getCurrentPlayer(),playerModel.getBeatFriend());
		}
	}
}
