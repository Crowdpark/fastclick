package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FinishGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		
		[Inject]
		public var backendService:BackendService;

		[Inject]
		public var stateMachineModel:StateMachineModel;
		override public function execute() : void
		{
			backendService.storeResults(playerModel.getCurrentPlayer());
			
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);
			
			var resultView : ResultView = new ResultView();
			resultView.init();
			
			mainSprite.addChild(resultView);
		}
	}
}
