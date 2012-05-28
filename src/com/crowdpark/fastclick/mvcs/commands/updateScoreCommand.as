package com.crowdpark.fastclick.mvcs.commands
{
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
			var score : uint = playerModel.getScore() + pointClickEvent.ball.getScore();
			
			playerModel.setScore(score);
		}
	}
}
