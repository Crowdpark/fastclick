package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.views.start.StartView;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class RetryGameCommand extends Command
	{
		override public function execute():void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new StartView());
		}
	}
}
