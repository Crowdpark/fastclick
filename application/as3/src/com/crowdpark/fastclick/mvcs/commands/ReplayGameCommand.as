package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.models.vo.ScoreVo;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class ReplayGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var stateMachineModel : StateMachineModel;

		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);

			stateMachineModel.state = StateMachineState.REPLAY;

			playerModel.getCurrentPlayer().setCurrentScore(new ScoreVo().setScore(0).setDate(uint(new Date().dateUTC)));
			playerModel.getCurrentPlayer().setClickedBallAmount(0);

			var startView : StartView = new StartView();
			startView.init();

			mainSprite.addChild(startView);
		}
	}
}
