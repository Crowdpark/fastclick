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

			addContextListener(LeaderboardEvent.SORT, handleLeaderBoard);
		}

		private function handleLeaderBoard(event : LeaderboardEvent) : void
		{
			var vbox : VBox = new VBox();
			vbox.spacing = 5;
			vbox.y = 20;
			
			var scoreArray:Array = playerModel.getScoreArray();
			trace(scoreArray);
			for(var i:uint; i<scoreArray.length;i++)
			{
				vbox.addChild(createField(scoreArray[i]));				
			}

			view.leaderboardPanel.addChild(createField(event.playerName));
			view.addChild(vbox);
		}

		private function get view() : LeaderboardView
		{
			return viewComponent as LeaderboardView;
		}
	}
}
