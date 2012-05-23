package com.crowdpark.fastclick.mvcs.views
{
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.events.FinishGameEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class HudViewMediator extends Mediator
	{
		override public function onRegister() : void
		{
			view.scoreTitle.x = 10;
			view.score.x = view.scoreTitle.width + 10;

			view.timeTitle.x = contextView.stage.stageWidth - 100;
			view.time.x = contextView.stage.stageWidth - 30;

			view.addEventListener("finish", handleFinishGame);
		}

		private function handleFinishGame(e:Event) : void
		{
			dispatch(new FinishGameEvent(FinishGameEvent.FINISH));
		}

		public function get view() : HudView
		{
			return viewComponent as HudView;
		}
	}
}
