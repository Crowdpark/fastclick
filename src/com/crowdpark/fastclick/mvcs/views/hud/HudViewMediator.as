package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;

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

			addContextListener(HudViewEvent.UPDATE, updateTime);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);
		}

		private function updateTime(e : HudViewEvent) : void
		{
			view.time.text = String(playerModel.getTime());
		}

		private function handlePointClickEvent(event : PointClickEvent) : void
		{
			view.score.text = String(playerModel.getScore());
		}

		override protected function handleFinish(e : StateMachineEvents) : void
		{
			super.handleFinish(e);
		}

		public function get view() : HudView
		{
			return viewComponent as HudView;
		}
	}
}
