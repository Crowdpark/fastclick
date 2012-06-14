package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BitmapLoaderService;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchFriendsPicturesCommand extends Command
	{
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var facebookService:FacebookService;
		
		[Inject]
		public var bitmapLoaderService:BitmapLoaderService;
		
		override public function execute() : void
		{
			
			facebookService.fetchFriendImages();
			
		}
	}
}
