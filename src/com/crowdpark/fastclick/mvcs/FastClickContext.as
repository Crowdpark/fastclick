package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.commands.CountDownCommand;
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartUpCompleteCommand;
	import com.crowdpark.fastclick.mvcs.commands.UpdateScoreCommand;
	import com.crowdpark.fastclick.mvcs.commands.RetryGameCommand;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownView;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownViewMeditor;
	import com.crowdpark.fastclick.mvcs.views.game.GameView;
	import com.crowdpark.fastclick.mvcs.views.game.GameViewMediator;
	import com.crowdpark.fastclick.mvcs.views.hud.HudView;
	import com.crowdpark.fastclick.mvcs.views.hud.HudViewMediator;
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
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartUpCompleteCommand);
			commandMap.mapEvent(StateMachineEvents.START, CountDownCommand);						
			commandMap.mapEvent(StateMachineEvents.GAME,StartGameCommand);		
			commandMap.mapEvent(StateMachineEvents.FINISH, FinishGameCommand);
			commandMap.mapEvent(StateMachineEvents.RETRY, RetryGameCommand);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, UpdateScoreCommand);
						
			injector.mapSingleton(PlayerModel);
			injector.mapSingleton(StateMachineModel);
			
			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView,CountDownViewMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator);
			
			super.startup();
		}

	}
}
