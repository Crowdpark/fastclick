package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StartGameCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;

		override public function execute() : void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new GameView());

			configModel.startTimer();
		}
	}
}
