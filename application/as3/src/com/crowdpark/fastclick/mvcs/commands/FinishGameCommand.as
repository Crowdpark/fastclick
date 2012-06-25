package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.vo.LevelVo;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
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
		public var configModel : ConfigModel;

		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);

			var resultView : ResultView = new ResultView();
			resultView.init();

			mainSprite.addChild(resultView);

			var currentPlayer : PlayerVo = playerModel.getCurrentPlayer();
			var currentScore : ScoreVo = currentPlayer.getCurrentScore();
			var currentLevel : uint = currentPlayer.getCurrentLevel();
			var selectedLevel : uint = currentPlayer.getSelectedLevel();

			if (selectedLevel == currentLevel)
			{
				var newLevel : uint = configModel.calculateLevel(currentScore.getScore(), currentLevel);
				currentPlayer.setCurrentLevel(newLevel);
				currentScore.setDate(0);
			}
			
			highestScoreModel.addScore(currentScore, selectedLevel);
			backendService.storeResult(currentPlayer);

			if (stateMachineModel.getGameState() != StateMachineState.REPLAYED)
			{
				backendService.getHighestScores(currentPlayer);
			}
			else
			{
				dispatch(new LeaderboardEvent(LeaderboardEvent.SHOW_HIGHEST_SCORE));
			}
		}
	}
}
