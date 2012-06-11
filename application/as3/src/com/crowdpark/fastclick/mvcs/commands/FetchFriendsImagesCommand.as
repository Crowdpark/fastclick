package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchFriendsImagesCommand extends Command
	{
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var facebookService:FacebookService;
		
		override public function execute() : void
		{
			facebookService.fetchFriendImages();
			
		}
	}
}
