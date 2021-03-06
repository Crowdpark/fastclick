package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class FinishGameCommand extends Command
	{
		[Inject]
		public var playerModel: PlayerModel;
		
		[Inject]
		public var highestScoreModel: HighestScoreModel;
		
		override public function execute() : void
		{
			contextView.removeChildAt(0);
			contextView.addChild(new ResultView().init());
			
			highestScoreModel.setHighscoreList(playerModel.getPlayerArray());
		}
	}
}
