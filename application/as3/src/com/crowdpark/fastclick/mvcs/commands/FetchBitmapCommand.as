package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FetchBitmapCommand extends Command
	{
		[Inject]
		public var bitmapService : BitmapFetcherService;
		[Inject]
		public var playerModel : PlayerModel;
		
		override public function execute() : void
		{
			var playerFriendsVector:Vector.<PlayerVo> = playerModel.getPlayerFriends();
			var currentFriend:PlayerVo = playerFriendsVector[playerFriendsVector.length-1];
			
			bitmapService.fetchBitMap(currentFriend.getPlayerPictureUrl());
		}
	}
}
