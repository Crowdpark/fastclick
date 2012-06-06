package com.crowdpark.fastclick.mvcs.views.hud
{
	import com.greensock.easing.Linear;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
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

			
			var hudViewBackground : Shape = createRectangleShape(contextView.stage.stageWidth, 60, 0x000000);
			view.addChild(hudViewBackground);

			var timeBar : Shape = createRectangleShape(10, contextView.stage.stageHeight - 120, 0, 10, contextView.stage.stageWidth - 10, view.height);
			var barMask : Shape = createRectangleShape(10, contextView.stage.stageHeight - 120, 0, 10, contextView.stage.stageWidth - 10, view.height);
			timeBar.mask = barMask;
			
			TweenMax.to(barMask, configModel.getGameDuration(), {y:contextView.stage.stageHeight-60,ease:Linear.easeNone});

			view.addChild(timeBar);
			view.addChild(barMask);

			view.init();
		
			view.scoreTitle.y = 20;
			view.scoreTitle.x = 5;
			view.score.x = 5;
			view.timeSprite.x = contextView.stage.stageWidth - view.timeSprite.width-20;
			view.playerNameSprite.x = view.timeSprite.x - 70;
			
			view.playerNameField.text = String(playerModel.getCurrentPlayer().getValueByKey('playerName'));
			view.playerNameSprite.getChildAt(0).width = view.playerNameField.width + 6;
			view.playerNameSprite.getChildAt(0).height = view.playerNameField.height+ 6;
			view.playerNameField.x = (view.playerNameSprite.width-view.playerNameField.width)/2; 
			view.playerNameField.y = (view.playerNameSprite.height-view.playerNameField.height)/2; 
			
			
			view.time.text = String(configModel.getGameDuration());
			view.timeSprite.x = contextView.stage.stageWidth - view.timeSprite.width-20;
			view.playerNameSprite.x = view.timeSprite.x - 70;
			
			
			
			addContextListener(HudViewEvent.UPDATE, updateTime);
			addContextListener(PointClickEvent.POINT_CLICK, handlePointClickEvent);
		}

		private function updateTime(e : HudViewEvent) : void
		{
			view.time.text = String(configModel.getTime());
			view.timeSprite.x = contextView.stage.stageWidth - view.timeSprite.width-20;
			view.playerNameSprite.x = view.timeSprite.x - 70;
			
		}

		private function handlePointClickEvent(event : PointClickEvent) : void
		{
			view.score.text = String(playerModel.getCurrentPlayer().getValueByKey('currentScore'));

			var scoreBox : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('scoreBox'));
			scoreBox.alpha = 0;
			view.addChild(scoreBox);

			TweenMax.to(scoreBox, 0.3, {alpha:1, x:scoreBox.getEndPoint().x, y:scoreBox.getEndPoint().y, onComplete:handleTweenComplete, onCompleteParams:[scoreBox]});
		}

		private function handleTweenComplete(scoreBox : InterfaceBall) : void
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
