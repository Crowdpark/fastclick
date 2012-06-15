package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;

	/**
	 * @author fatmatekin
	 */
	public class HudViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			view.getDataProvider().setValueByKey('playerName', playerModel.getCurrentPlayer().getValueByKey('playerName'));
			view.getDataProvider().setValueByKey('playerLastName', playerModel.getCurrentPlayer().getValueByKey('playerLastName'));
			view.getDataProvider().setValueByKey('gameDuration', configModel.getGameDuration());

			addContextListener(HudViewEvent.UPDATE, updateTime);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);

			trace(playerModel.getCurrentPlayer().getSelectedLevel());
			view.updateLevel(uint(playerModel.getCurrentPlayer().getSelectedLevel()));
		}

		private function updateTime(e : HudViewEvent) : void
		{
			view.getDataProvider().setValueByKey('time', String(configModel.getTime()));
			view.updateTime();
		}

		private function handlePointClickEvent(event : PointClickEvent) : void
		{
			view.score.text = String(playerModel.getCurrentPlayer().getValueByKey('currentScore'));

			var scoreBox : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('scoreBox'));
			scoreBox.alpha = 0;
			view.addChild(scoreBox);

			TweenMax.to(scoreBox, 0.3, {alpha:1, x:scoreBox.getEndPoint().x, y:scoreBox.getEndPoint().y, onComplete:handleTweenComplete, onCompleteParams:[scoreBox]});
		}

		private function handleTweenComplete(scoreBox : InterfaceCircle) : void
		{
			if (view)
			{
				view.removeChild(DisplayObject(scoreBox));
			}
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
