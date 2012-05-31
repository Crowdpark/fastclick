package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;
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
			var ballScore : uint = BaseBall(pointClickEvent.getDataprovider().getValueByKey('fcBall')).getScore();
			var score : uint = ballScore + uint(playerModel.getCurrentPlayer().getValueByKey('currentScore'));
			playerModel.getCurrentPlayer().setValueByKey('currentScore', score);
		}
	}
}
