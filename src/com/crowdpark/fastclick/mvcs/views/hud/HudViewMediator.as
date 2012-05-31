package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import utils.draw.createRectangleShape;





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
			
			view.score.text = String(playerModel.getCurrentPlayer().getValueByKey('currentScore'));

			var scoreBox:BaseBall = BaseBall(event.getDataprovider().getValueByKey('scoreBox'));
			scoreBox.alpha = 0;
			view.addChild(scoreBox);
			
			TweenMax.to(scoreBox, 0.3, {alpha:1,x:scoreBox.getEndPoint().x, y:scoreBox.getEndPoint().y, onComplete:handleTweenComplete, onCompleteParams:[scoreBox]});
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
