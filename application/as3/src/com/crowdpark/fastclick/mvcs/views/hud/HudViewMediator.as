package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;

	/**
	 * @author fatmatekin
	 */
	public class HudViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.getDataProvider().setValueByKey('playerName', playerModel.getCurrentPlayer().getValueByKey('playerName'));
			view.getDataProvider().setValueByKey('playerLastName', playerModel.getCurrentPlayer().getValueByKey('playerLastName'));
			view.getDataProvider().setValueByKey('gameDuration', configModel.getGameDuration());

			addContextListener(HudViewEvent.UPDATE, updateTime);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);

			var currentPlayer : PlayerVo = playerModel.getCurrentPlayer();
			var selectedLevel : uint = uint(currentPlayer.getSelectedLevel());

			var neededScore : uint;
			var upperLevel : uint;

			if (selectedLevel < configModel.getLevelArray().length)
			{
				neededScore = uint(configModel.getLevelArray()[selectedLevel - 1].getScoreLimit());
				upperLevel = configModel.getLevelArray()[selectedLevel].getLevelIndex();
			}

			view.updateLevel(selectedLevel, neededScore, upperLevel);
			view.updateScore(String(currentPlayer.getCurrentScore().getScore()));
		}

		private function updateTime(e : HudViewEvent) : void
		{
			view.updateTime(configModel.getTime());
		}

		private function handlePointClickEvent(event : PointClickEvent) : void
		{
			var currentScore : ScoreVo = ScoreVo(playerModel.getCurrentPlayer().getCurrentScore());
			view.updateScore(String(currentScore.getScore()));

			var scoreBox : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('scoreBox'));
			scoreBox.alpha = 0;

			view.addScoreBox(scoreBox);
		}

		public function get view() : HudView
		{
			return viewComponent as HudView;
		}
	}
}
