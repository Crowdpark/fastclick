package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.views.levels.LevelsView;

	import flash.display.Sprite;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class PlayGameCommand extends Command
	{
		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);

			var levelView : LevelsView = new LevelsView();
			levelView.init();
			

			mainSprite.addChild(levelView);
		}
	}
}
