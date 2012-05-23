package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.StartView;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class retryGameCommand extends Command
	{
		[Inject]
		public var playerModel:PlayerModel;
		override public function execute():void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new StartView());
			
			playerModel.score = 0;
		}
	}
}
