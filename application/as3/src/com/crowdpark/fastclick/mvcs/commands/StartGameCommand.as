package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class StartGameCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;
	
		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);

			var gameView : GameView = new GameView();
			gameView.init();

			
			mainSprite.addChild(gameView);
			configModel.startTimer();
		}
	}
}
