package com.crowdpark.fastclick.mvcs.views.leaderboard
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import utils.textField.createField;

	import com.bit101.components.VBox;
	import com.crowdpark.fastclick.mvcs.events.LeaderboardEvent;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;

	/**
	 * @author fatmatekin
	 */
	public class LeaderboardViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			addContextListener(LeaderboardEvent.SORT, handleLeaderBoard);
		}

		private function handleLeaderBoard(event : LeaderboardEvent) : void
		{
			var vbox : VBox = new VBox();
			vbox.spacing = 5;
			vbox.y = 5;

			var playerArray : Array = playerModel.getPlayerArray();
			for (var i : uint; i < playerArray.length;i++)
			{
				var currentPlayer : PlayerVo = playerArray[i];

				vbox.addChild(createField(String(currentPlayer.playerName.value) + "-" + String(currentPlayer.getCurrentScore().value), 5, 0, 200, 20, false, "Verdana", 15));
			}

			view.leaderboardPanel.addChild(vbox);
		}

		private function get view() : LeaderboardView
		{
			return viewComponent as LeaderboardView;
		}
	}
}
