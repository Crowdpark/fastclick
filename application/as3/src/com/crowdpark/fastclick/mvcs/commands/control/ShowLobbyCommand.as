package com.crowdpark.fastclick.mvcs.commands.control
{
	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ShowLobbyCommand extends Command
	{
		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			while (mainSprite.numChildren > 0)
			{
				mainSprite.removeChildAt(0);
			}

			var startView : StartView = new StartView();
			startView.init();
			startView.addStartButton();

			mainSprite.addChild(startView);
		}
	}
}
