package com.crowdpark.fastclick.mvcs.commands.control
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;

	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class ShowLobbyCommand extends Command
	{
		[Inject]
		public var configModel : ConfigModel;
		[Inject]
		public var stateMachineModel : StateMachineModel;
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			while (mainSprite.numChildren > 0)
			{
				mainSprite.removeChildAt(0);
			}
			stateMachineModel.state = StateMachineState.LOBBY;

			configModel.stopTimer();
			playerModel.resetGame();

			var startView : StartView = new StartView();
			startView.init();
			mainSprite.addChild(startView);
		}
	}
}
