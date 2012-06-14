package com.crowdpark.fastclick.mvcs.commands
{
	import flash.display.Bitmap;
	import com.crowdpark.fastclick.mvcs.events.BitmapLoaderServiceEvent;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class BitmapLoadedCommand extends Command
	{
		[Inject]
		public var facebookService:FacebookService;
		
		[Inject]
		public var blsEvent:BitmapLoaderServiceEvent;
		
		
		override public function execute() : void
		{
			facebookService.addLoadedBitmap(Bitmap(blsEvent.getDataprovider().getValueByKey('bitmap')));
		}
	}
}
