package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.commands.CountDownCommand;
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.RetryGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.SetPlayerCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartUpCompleteCommand;
	import com.crowdpark.fastclick.mvcs.commands.UpdateScoreCommand;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.ConfigModel;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.services.ConfigService;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownView;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownViewMeditor;
	import com.crowdpark.fastclick.mvcs.views.footer.FooterView;
	import com.crowdpark.fastclick.mvcs.views.footer.FooterViewMediator;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;
	import com.crowdpark.fastclick.mvcs.views.game.GameViewMediator;
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewMediator;
	import com.crowdpark.fastclick.mvcs.views.leaderboard.LeaderboardView;
	import com.crowdpark.fastclick.mvcs.views.leaderboard.LeaderboardViewMediator;
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
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartUpCompleteCommand,ContextEvent);
			commandMap.mapEvent(StateMachineEvents.START, CountDownCommand,StateMachineEvents);
			commandMap.mapEvent(GameEvents.SET_PLAYER, SetPlayerCommand,GameEvents);
									
			commandMap.mapEvent(StateMachineEvents.GAME,StartGameCommand,StateMachineEvents);		
			commandMap.mapEvent(StateMachineEvents.FINISH, FinishGameCommand,StateMachineEvents);
			commandMap.mapEvent(StateMachineEvents.RETRY, RetryGameCommand,StateMachineEvents);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, UpdateScoreCommand,PointClickEvent);
			
						
			injector.mapSingleton(PlayerModel);
			injector.mapSingleton(StateMachineModel);
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(ConfigService);
			
			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView,CountDownViewMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator);
			mediatorMap.mapView(LeaderboardView, LeaderboardViewMediator);
			mediatorMap.mapView(FooterView, FooterViewMediator);
			
			super.startup();
		}

	}
}
