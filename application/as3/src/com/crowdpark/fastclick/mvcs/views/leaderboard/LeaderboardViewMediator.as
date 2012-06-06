package com.crowdpark.fastclick.mvcs.views.leaderboard
{
	import com.bit101.components.VBox;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import utils.textField.createField;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardViewMediator extends StateMachineMediator
	{
		private var vbox : VBox = new VBox();

		override public function onRegister() : void
		{
			super.onRegister();
			vbox.spacing = 5;
			vbox.y = 5;

			addContextListener(LeaderboardEvent.SORT, handleLeaderBoard);
		}

		private function handleLeaderBoard(event : LeaderboardEvent) : void
		{
			var playerArray : Vector.<PlayerVo> = highestScoreModel.getHighscoreList();
			for (var i : uint; i < playerArray.length;i++)
			{
				var currentPlayer : PlayerVo = playerArray[i];
				vbox.addChild(createField(String(currentPlayer.getValueByKey('playerName')) + " - " + String(currentPlayer.getValueByKey('currentScore')), 5, 0, 200, 20, false, "Verdana", 15));
			}

			view.leaderboardPanel.addChild(vbox);
			view.leaderboardPanel.update();
		}

		private function get view() : LeaderboardView
		{
			return viewComponent as LeaderboardView;
		}
	}
}
