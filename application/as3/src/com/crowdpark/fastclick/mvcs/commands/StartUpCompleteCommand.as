package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.views.friends.FriendsView;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class StartUpCompleteCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;
		[Inject]
		public var facebookService : FacebookService;
		[Inject]
		public var configService : ConfigService;
		
		[Inject]
		public var stateMachineModel:StateMachineModel;
		

		override public function execute() : void
		{
			facebookService.init();
			configService.fetchData("data/Config.json");
			
			stateMachineModel.state = StateMachineState.LOADING;
			
			var mainSprite : Sprite = new Sprite();
			mainSprite.name = 'mainSprite';
			var friendsSprite : Sprite = new Sprite();
			friendsSprite.name = 'friendsSprite';

			var startView : StartView = new StartView();
			startView.init();

			var friends : FriendsView = new FriendsView();
			friends.init();

			friendsSprite.addChild(friends);
			mainSprite.addChild(startView);

			contextView.addChild(mainSprite);
			contextView.addChild(friendsSprite);

			
		}
	}
}
