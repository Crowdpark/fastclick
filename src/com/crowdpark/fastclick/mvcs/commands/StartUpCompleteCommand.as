package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;


	/**
	 * @author fatmatekin
	 */
	public class StartUpCompleteCommand extends Command
	{
		[Inject]
		public var configService:ConfigService;
		
		override public function execute() : void
		{
			var startView : StartView = new StartView().init();
			contextView.addChild(startView);
			
			configService.fetchData("data/Config.json"); 
		}
	}
}
