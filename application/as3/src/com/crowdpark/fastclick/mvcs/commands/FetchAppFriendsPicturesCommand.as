package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchAppFriendsPicturesCommand extends Command
	{
		[Inject]
		public var facebookService:FacebookService;
		
		override public function execute() : void
		{
			facebookService.fetchAppFriendImages();
		}
	}
}
