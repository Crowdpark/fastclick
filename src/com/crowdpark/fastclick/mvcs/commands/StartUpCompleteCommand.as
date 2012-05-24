package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.views.start.StartView;
	import org.robotlegs.mvcs.Command;


	/**
	 * @author fatmatekin
	 */
	public class StartUpCompleteCommand extends Command
	{
		override public function execute() : void
		{
			var startView : StartView = new StartView();
			contextView.addChild(startView);
		}
	}
}
