package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchAllFriendsPicturesCommand extends Command
	{
		[Inject]
		public var facebookService : FacebookService;
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var bitmapService : BitmapFetcherService;
		public var friendIndex : uint = 0;

		override public function execute() : void
		{
			facebookService.fetchFriendImages();
		}
	}
}
