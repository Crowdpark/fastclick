package com.crowdpark.fastclick.mvcs.views.leaderboard
{
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

			view.leaderboardPanel.y = view.playerName.y+view.playerName.textHeight+20;
			addContextListener(LeaderboardEvent.SORT, handleLeaderBoard);
		}

		private function handleLeaderBoard(event : LeaderboardEvent) : void
		{
			var vbox : VBox = new VBox();
			vbox.spacing = 5;
			vbox.y = 5;

			var scoreArray : Array = playerModel.getScoreArray();
			for (var i : uint; i < scoreArray.length;i++)
			{
				vbox.addChild(createField(scoreArray[i]));
			}

			view.playerName.text = event.playerName;
			view.leaderboardPanel.addChild(vbox);
		}

		private function get view() : LeaderboardView
		{
			return viewComponent as LeaderboardView;
		}
	}
}
