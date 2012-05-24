package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.core.StateMachineModel;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.retryGameCommand;
	import com.crowdpark.fastclick.mvcs.views.ResultViewMediator;
	import com.crowdpark.fastclick.mvcs.views.ResultView;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.commands.updateScoreCommand;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.views.PointsViewMediator;
	import com.crowdpark.fastclick.mvcs.views.PointsView;
	import com.crowdpark.fastclick.mvcs.views.HudViewMediator;
	import com.crowdpark.fastclick.mvcs.views.HudView;
	import com.crowdpark.fastclick.mvcs.commands.CountDownCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.StartUpCompleteCommand;
	import com.crowdpark.fastclick.mvcs.views.CountDownMeditor;
	import com.crowdpark.fastclick.mvcs.views.CountDownView;
	import com.crowdpark.fastclick.mvcs.views.GameView;
	import com.crowdpark.fastclick.mvcs.views.GameViewMediator;
	import com.crowdpark.fastclick.mvcs.views.StartView;
	import com.crowdpark.fastclick.mvcs.views.StartViewMediator;
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
			commandMap.mapEvent(StateMachineEvents.RETRY, retryGameCommand);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, updateScoreCommand);
			
			super.startup();
			
			injector.mapSingleton(PlayerModel);
			injector.mapSingleton(StateMachineModel);
			
			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView,CountDownMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator);
		}

	}
}
