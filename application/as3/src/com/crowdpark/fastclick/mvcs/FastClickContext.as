package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.commands.SaveConfigDataCommand;
	import com.crowdpark.fastclick.mvcs.commands.BitmapLoadedCommand;
	import com.crowdpark.fastclick.mvcs.commands.CountDownCommand;
	import com.crowdpark.fastclick.mvcs.commands.FetchAppFriendsPicturesCommand;
	import com.crowdpark.fastclick.mvcs.commands.FetchFriendsPicturesCommand;
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.InviteFriendCommand;
	import com.crowdpark.fastclick.mvcs.commands.LoadBitmapCommand;
	import com.crowdpark.fastclick.mvcs.commands.LogoutCommand;
	import com.crowdpark.fastclick.mvcs.commands.RetryGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.SetPlayerCookieCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartUpCompleteCommand;
	import com.crowdpark.fastclick.mvcs.commands.StorePlayerCommand;
	import com.crowdpark.fastclick.mvcs.commands.UpdateScoreCommand;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvents;
	import com.crowdpark.fastclick.mvcs.events.BitmapLoaderServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.services.BitmapLoaderService;
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownView;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownViewMeditor;
	import com.crowdpark.fastclick.mvcs.views.footer.FooterView;
	import com.crowdpark.fastclick.mvcs.views.footer.FooterViewMediator;
	import com.crowdpark.fastclick.mvcs.views.friends.FriendsView;
	import com.crowdpark.fastclick.mvcs.views.friends.FriendsViewMediator;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;
	import com.crowdpark.fastclick.mvcs.views.game.GameViewMediator;
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewMediator;
	import com.crowdpark.fastclick.mvcs.views.levels.LevelsView;
	import com.crowdpark.fastclick.mvcs.views.levels.LevelsViewMediator;
	import com.crowdpark.fastclick.mvcs.views.points.PointsView;
	import com.crowdpark.fastclick.mvcs.views.points.PointsViewMediator;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;
	import com.crowdpark.fastclick.mvcs.views.result.ResultViewMediator;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;
	import com.crowdpark.fastclick.mvcs.views.start.StartViewMediator;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;



	/**
	 * @author fatmatekin
	 */
	public class FastClickContext extends Context
	{
		public function FastClickContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true)
		{
			super(contextView, autoStartup);
		}

		override public function startup() : void
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartUpCompleteCommand, ContextEvent);
			commandMap.mapEvent(StateMachineEvents.START, CountDownCommand, StateMachineEvents);
			commandMap.mapEvent(BackendServiceEvents.SAVE_CONFIG_DATA, SaveConfigDataCommand);
			commandMap.mapEvent(BackendServiceEvents.FETCH_ALL_FRIENDS, SetAllFriendsCommand);
			
			commandMap.mapEvent(FacebookServiceEvent.FETCH_FRIENDS_PICTURES, FetchFriendsPicturesCommand, FacebookServiceEvent);
			commandMap.mapEvent(FacebookServiceEvent.FETCH_APP_FRIENDS_IMAGES, FetchAppFriendsPicturesCommand, FacebookServiceEvent);
			commandMap.mapEvent(BitmapLoaderServiceEvent.LOAD_BITMAP, LoadBitmapCommand);
			commandMap.mapEvent(BitmapLoaderServiceEvent.BITMAP_LOADED, BitmapLoadedCommand);
			commandMap.mapEvent(BackendServiceEvents.STORE_PLAYER, StorePlayerCommand);
			
			commandMap.mapEvent(GameEvents.SET_PLAYER_COOKIE, SetPlayerCookieCommand, GameEvents);
			commandMap.mapEvent(StateMachineEvents.GAME, StartGameCommand, StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.FINISH, FinishGameCommand, StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.RETRY, RetryGameCommand, StateMachineEvents);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, UpdateScoreCommand, PointClickEvent);
			commandMap.mapEvent(FacebookServiceEvent.LOG_OUT, LogoutCommand);
			commandMap.mapEvent(FacebookServiceEvent.INVITE_FRIEND, InviteFriendCommand);

			injector.mapSingleton(PlayerModel);
			injector.mapSingleton(StateMachineModel);
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(HighestScoreModel);
			injector.mapSingleton(ConfigService);
			injector.mapSingleton(FacebookService);
			injector.mapSingleton(BackendService);
			injector.mapClass(BitmapLoaderService, BitmapLoaderService);

			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView, CountDownViewMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator);
			mediatorMap.mapView(FooterView, FooterViewMediator);
			mediatorMap.mapView(FriendsView, FriendsViewMediator);
			mediatorMap.mapView(LevelsView, LevelsViewMediator);

			super.startup();
		}
	}
}
