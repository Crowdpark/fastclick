package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class RefreshLeaderboardCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var configModel : ConfigModel;
		[Inject]
		public var backendService : BackendService;
		[Inject]
		public var leaderboardEvent : LeaderboardEvent;

		override public function execute() : void
		{
			var result : Object = leaderboardEvent.getDataprovider().getValueByKey('result');

			playerModel.updateHighScores(result);
			playerModel.getPlayerAppFriends().push(playerModel.getCurrentPlayer());

			var currentPlayer : PlayerVo = playerModel.getCurrentPlayer();
			var currentScore : ScoreVo = currentPlayer.getCurrentScore();
			var currentLevel : uint = currentPlayer.getCurrentLevel();
			var selectedLevel : uint = currentPlayer.getSelectedLevel();
			var highestScore : ScoreVo = currentPlayer.getHighestScore();

			if (selectedLevel == currentLevel)
			{
				var newLevel : uint = configModel.calculateLevel(currentScore.getScore(), currentLevel);
				currentPlayer.setCurrentLevel(newLevel);
				if (newLevel == currentLevel && currentScore.getScore() > highestScore.getScore())
				{
					currentPlayer.setHighestScore(currentScore);
				}
				else if (newLevel > currentLevel)
				{
					var newScore : ScoreVo = new ScoreVo();
					newScore.setScore(0);
					currentPlayer.setHighestScore(newScore);
					currentScore = newScore;
				}
			}
			playerModel.sortLeaderBoard();
			backendService.storeResult(currentPlayer);
		}
	}
}
