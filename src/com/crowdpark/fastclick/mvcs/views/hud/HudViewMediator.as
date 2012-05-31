package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;

	import utils.draw.createRectangleShape;

	import flash.display.Shape;

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

			var hudViewBackground : Shape = createRectangleShape(contextView.stage.stageWidth, 50, 0xb3b3b3);
			view.addChild(hudViewBackground);

			view.init();

			view.scoreTitle.y = 20;
			view.scoreTitle.x = 5;
			view.score.x = 5;

			view.timeSprite.x = contextView.stage.stageWidth - 50;

			addContextListener(HudViewEvent.UPDATE, updateTime);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);
		}

		private function updateTime(e : HudViewEvent) : void
		{
			view.time.text = String(configModel.getTime());
		}

		private function handlePointClickEvent(event : PointClickEvent) : void
		{
			view.score.text = String(playerModel.getCurrentPlayer().getCurrentScore().value);
			var scoreBox:DisplayObject = DisplayObject(event.scoreBox);
			scoreBox.alpha = 0;
			view.addChild(scoreBox);
			
			TweenMax.to(event.scoreBox, 0.3, {alpha:1,x:event.scoreBox.getEndPoint().x, y:event.scoreBox.getEndPoint().y, onComplete:handleTweenComplete, onCompleteParams:[event.scoreBox]});
		}

		private function handleTweenComplete(scoreBox : InterfaceBall) : void
		{
			if(view)
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
