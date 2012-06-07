package com.crowdpark.fastclick.mvcs.commands
{
	import flash.net.SharedObject;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
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
		
		[Inject]
		public var playerModel : PlayerModel;
		
		override public function execute() : void
		{
			contextView.removeChildAt(0);
			var gameView : GameView = new GameView();
			gameView.init();
			
			var flashCookie : SharedObject = SharedObject(playerModel.getFlashCookie());
			
			gameView.hudView.getDataProvider().setValueByKey('playerName', flashCookie.data.playername);
			contextView.addChild(gameView);
			configModel.startTimer();
		}
	}
}
