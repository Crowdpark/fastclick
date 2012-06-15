package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BitmapLoaderService;
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
		
		[Inject]
		public var bitmapLoaderService:BitmapLoaderService;
				
		
		override public function execute() : void
		{
						
			facebookService.addLoadedBitmap(Bitmap(blsEvent.getDataprovider().getValueByKey('bitmap')));
		}
	}
}
