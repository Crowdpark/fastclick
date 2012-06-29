package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class UpdateScoreCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var pointClickEvent : PointClickEvent;

		override public function execute() : void
		{
			var ballScore : uint = BaseGraphic(pointClickEvent.getDataprovider().getValueByKey('fcCircle')).getScore();
			var score : uint = ballScore + playerModel.getCurrentPlayer().getCurrentScore().getScore();
			var ballAmount : uint = playerModel.getCurrentPlayer().getClickedBallAmount() + 1;
			
			

			playerModel.getCurrentPlayer().setCurrentScore(new ScoreVo().setScore(score).setDate(uint(new Date().dateUTC)));
			playerModel.getCurrentPlayer().setClickedBallAmount(ballAmount);
		}
	}
}
