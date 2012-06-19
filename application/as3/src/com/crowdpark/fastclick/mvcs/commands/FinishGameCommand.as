package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.GameModel;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FinishGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var stateMachineModel : StateMachineModel;
		[Inject]
		public var highestScoreModel : HighestScoreModel;
		[Inject]
		public var gameModel : GameModel;

		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);

			var resultView : ResultView = new ResultView();
			resultView.init();

			mainSprite.addChild(resultView);

			if (gameModel.getState() == GameModel.REPLAY)
			{
				highestScoreModel.addScore(playerModel.getCurrentPlayer().getCurrentScore());
			}
			else
			{
				backendService.getHighestScores(playerModel.getCurrentPlayer());
			}
		}
	}
}
