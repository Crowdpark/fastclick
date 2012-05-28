package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StartGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new GameView());

			playerModel.startTimer();
		}
	}
}
