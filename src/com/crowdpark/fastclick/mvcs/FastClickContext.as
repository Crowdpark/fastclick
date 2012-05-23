package com.crowdpark.fastclick.mvcs
{
	import com.crowdpark.fastclick.mvcs.commands.FinishGameCommand;
	import com.crowdpark.fastclick.mvcs.commands.retryGameCommand;
	import com.crowdpark.fastclick.mvcs.events.RetryGameEvent;
	import com.crowdpark.fastclick.mvcs.views.ResultViewMediator;
	import com.crowdpark.fastclick.mvcs.views.ResultView;
	import com.crowdpark.fastclick.mvcs.events.FinishGameEvent;
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
	import com.crowdpark.fastclick.mvcs.events.CountDownFinishEvent;
	import com.crowdpark.fastclick.mvcs.events.StartClickEvent;
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
			commandMap.mapEvent(StartClickEvent.START_COUNTDOWN, CountDownCommand);
			commandMap.mapEvent(CountDownFinishEvent.COUNTDOWN_FINISH,StartGameCommand);
			commandMap.mapEvent(PointClickEvent.POINT_CLICK, updateScoreCommand);
			commandMap.mapEvent(FinishGameEvent.FINISH, FinishGameCommand);
			
			
			commandMap.mapEvent(RetryGameEvent.RETRY_GAME, retryGameCommand);
			super.startup();
			
			injector.mapSingleton(PlayerModel);
			
			mediatorMap.mapView(StartView, StartViewMediator);
			mediatorMap.mapView(CountDownView,CountDownMeditor);
			mediatorMap.mapView(GameView, GameViewMediator);
			mediatorMap.mapView(HudView, HudViewMediator);
			mediatorMap.mapView(PointsView, PointsViewMediator);
			mediatorMap.mapView(ResultView, ResultViewMediator)
		}

	}
}
