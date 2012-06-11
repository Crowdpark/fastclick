package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import flash.display.Sprite;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FinishGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var highestScoreModel : HighestScoreModel;
		[Inject]
		public var backendService:BackendService;

		override public function execute() : void
		{
			backendService.storePlayer(playerModel.getCurrentPlayer());
			
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);
			
			var resultView : ResultView = new ResultView();
			resultView.init();
			
			mainSprite.addChild(resultView);
			
			highestScoreModel.setHighscoreList(playerModel.getPlayerArray());
		}
	}
}
