package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.views.GameView;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StartGameCommand extends Command
	{
		override public function execute() : void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new GameView());
		}
	}
}
