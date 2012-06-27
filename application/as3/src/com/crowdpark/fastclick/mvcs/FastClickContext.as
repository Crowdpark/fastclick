package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.commands.AddGiftCommand;
	import com.crowdpark.fastclick.mvcs.commands.BitmapFetchedCommand;
	import com.crowdpark.fastclick.mvcs.commands.CountDownCommand;
	import com.crowdpark.fastclick.mvcs.commands.CreatePlayerCommand;
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.ReplayGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.SaveConfigDataCommand;
	import com.crowdpark.fastclick.mvcs.commands.SendGiftBackendCommand;
	import com.crowdpark.fastclick.mvcs.commands.SendGiftCommand;
	import com.crowdpark.fastclick.mvcs.commands.SetAppFriendsCommand;
	import com.crowdpark.fastclick.mvcs.commands.SetPlayerCookieCommand;
	import com.crowdpark.fastclick.mvcs.commands.ShowAppFriendsCommand;
	import com.crowdpark.fastclick.mvcs.commands.ShowLevelsCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartUpCompleteCommand;
	import com.crowdpark.fastclick.mvcs.commands.StoreGetAppFriendsCommand;
	import com.crowdpark.fastclick.mvcs.commands.UpdateScoreCommand;
	import com.crowdpark.fastclick.mvcs.commands.control.InviteFriendCommand;
	import com.crowdpark.fastclick.mvcs.commands.control.SendGiftsCommand;
	import com.crowdpark.fastclick.mvcs.commands.control.ShowLobbyCommand;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.events.BackendServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.BitmapFetcherServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.GiftModel;
	import com.crowdpark.fastclick.mvcs.models.HighestScoreModel;
	import com.crowdpark.fastclick.mvcs.models.LoadingModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.BackendService;
	import com.crowdpark.fastclick.mvcs.services.BitmapFetcherService;
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.services.FacebookService;
	import com.crowdpark.fastclick.mvcs.views.control.ControlView;
	import com.crowdpark.fastclick.mvcs.views.control.ControlViewEvent;
	import com.crowdpark.fastclick.mvcs.views.control.ControlViewMediator;
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
	import com.crowdpark.fastclick.mvcs.views.loading.LoadingView;
	import com.crowdpark.fastclick.mvcs.views.loading.LoadingViewMediator;
	import com.crowdpark.fastclick.mvcs.views.points.PointsView;
	import com.crowdpark.fastclick.mvcs.views.points.PointsViewMediator;
	import com.crowdpark.fastclick.mvcs.views.result.ResultView;
	import com.crowdpark.fastclick.mvcs.views.result.ResultViewMediator;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;
	import com.crowdpark.fastclick.mvcs.views.start.StartViewMediator;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

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
			commandMap.mapEvent(FacebookServiceEvent.CREATE_PLAYER, CreatePlayerCommand);
			commandMap.mapEvent(BackendServiceEvent.CREATE_FRIENDS, StoreGetAppFriendsCommand, BackendServiceEvent);
			commandMap.mapEvent(BackendServiceEvent.SET_APP_FRIENDS, SetAppFriendsCommand, BackendServiceEvent);
			commandMap.mapEvent(BitmapFetcherServiceEvent.BITMAP_FETCHED, BitmapFetchedCommand, BitmapFetcherServiceEvent);
			commandMap.mapEvent(BitmapFetcherServiceEvent.APP_FETCHED, ShowAppFriendsCommand, BitmapFetcherServiceEvent);

			commandMap.mapEvent(StateMachineEvents.PLAY_GAME, ShowLevelsCommand, StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.START, CountDownCommand, StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.GAME, StartGameCommand, StateMachineEvents);

			commandMap.mapEvent(BackendServiceEvent.SAVE_CONFIG_DATA, SaveConfigDataCommand, BackendServiceEvent);
			commandMap.mapEvent(GameEvents.SET_PLAYER_COOKIE, SetPlayerCookieCommand, GameEvents);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, UpdateScoreCommand, PointClickEvent);
			commandMap.mapEvent(FacebookServiceEvent.INVITE_FRIEND, InviteFriendCommand, FacebookServiceEvent);

			commandMap.mapEvent(GiftEvent.SEND_GIFT, SendGiftCommand, GiftEvent);
			commandMap.mapEvent(GiftEvent.ADD_GIFT, AddGiftCommand, GiftEvent);

			commandMap.mapEvent(BackendServiceEvent.SEND_GIFT_BACKEND, SendGiftBackendCommand, BackendServiceEvent);

			commandMap.mapEvent(StateMachineEvents.FINISH, FinishGameCommand, StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.REPLAY, ReplayGameCommand, StateMachineEvents);

			commandMap.mapEvent(ControlViewEvent.INVITE_FRIENDS, InviteFriendCommand);
			commandMap.mapEvent(ControlViewEvent.SHOW_LOBBY, ShowLobbyCommand);
			commandMap.mapEvent(ControlViewEvent.SEND_GIFTS, SendGiftsCommand);

			injector.mapSingleton(PlayerModel);
			injector.mapSingleton(StateMachineModel);
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(HighestScoreModel);
			injector.mapSingleton(GiftModel);

			injector.mapSingleton(ConfigService);
			injector.mapSingleton(FacebookService);
			injector.mapSingleton(BackendService);
			injector.mapClass(BitmapFetcherService, BitmapFetcherService);
			injector.mapSingleton(LoadingModel);

			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView, CountDownViewMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator);
			mediatorMap.mapView(FooterView, FooterViewMediator);
			mediatorMap.mapView(FriendsView, FriendsViewMediator);
			mediatorMap.mapView(LevelsView, LevelsViewMediator);
			mediatorMap.mapView(ControlView, ControlViewMediator);
			mediatorMap.mapView(LoadingView, LoadingViewMediator);

			super.startup();
		}
	}
}
