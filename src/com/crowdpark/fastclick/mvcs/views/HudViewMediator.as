package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class HudViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.scoreTitle.x = 10;
			view.score.x = view.scoreTitle.width + 10;

			view.timeTitle.x = contextView.stage.stageWidth - 100;
			view.time.x = contextView.stage.stageWidth - 30;
			
			eventMap.mapListener(view, "finish", handleFinishGame);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);
		}

		private function handlePointClickEvent(event:PointClickEvent) : void
		{
			view.score.text = String(playerModel.score);
		}
		override protected function handleFinish(e : Event) : void
		{
				super.handleFinish(e);						
		}
		private function handleFinishGame(e:Event) : void
		{
			dispatch(new StateMachineEvents(StateMachineEvents.FINISH));	
		}

		public function get view() : HudView
		{
			return viewComponent as HudView;
		}
	}
}
