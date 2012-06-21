package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class SendGiftBackendCommand extends Command
	{
		[Inject]
		public var backendServiceEvent : BackendServiceEvents;
		[Inject]
		public var backendService : BackendService;

		override public function execute() : void
		{
			backendService.sendGift(GiftVo(backendServiceEvent.getDataprovider().getValueByKey('data')));
		}
	}
}
