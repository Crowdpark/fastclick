package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class GameViewMediator extends Mediator
	{
		[Inject]
		public var playerModel:PlayerModel
		override public function onRegister() : void
		{
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);
		}

		private function handlePointClickEvent(event:PointClickEvent) : void
		{
			view.hudView.score.text = String(playerModel.score);
		}

		private function get view() : GameView
		{
			return viewComponent as GameView;
		}
	}
}
