package com.crowdpark.fastclick.mvcs.commands
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.views.control.ControlView;
	import com.crowdpark.fastclick.mvcs.views.friends.FriendsView;
	import com.crowdpark.fastclick.mvcs.views.loading.LoadingView;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class StartUpCompleteCommand extends Command
	{
		[Inject]
		public var facebookService : FacebookService;
		[Inject]
		public var configService : ConfigService;
		[Inject]
		public var stateMachineModel : StateMachineModel;
		[Inject]
		public var loadingModel : LoadingModel;

		override public function execute() : void
		{
			configService.fetchData("data/Config.json");
			facebookService.init();

			var mainSprite : Sprite = new Sprite();
			mainSprite.name = 'mainSprite';
			var friendsSprite : Sprite = new Sprite();
			friendsSprite.name = 'friendsSprite';

			var controlView : ControlView = new ControlView();
			controlView.init();

			var startView : StartView = new StartView();
			startView.init();

			var loadingView : LoadingView = new LoadingView();
			loadingView.name = 'loading';
			loadingView.init();
			loadingModel.setLoadingState('connecting to facebook');

			var friends : FriendsView = new FriendsView();
			friends.init();

			friendsSprite.addChild(friends);
			mainSprite.addChild(startView);

			contextView.addChild(mainSprite);
			contextView.addChild(friendsSprite);
			contextView.addChild(controlView);
			contextView.addChild(loadingView);
		}
	}
}
