package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.bit101.components.HBox;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FooterViewMediator extends StateMachineMediator
	{
		private var hbox : HBox = new HBox();

		override public function onRegister() : void
		{
			super.onRegister();

			view.addBallPane();
			view.ballPanel.move(0, contextView.stage.stageHeight - 60);

			hbox.x = 30;
			hbox.y = 30;
			hbox.spacing = 20;

			view.ballPanel.addChild(hbox);

			addContextListener(PointClickEvent.POINT_CLICK, handlePoinClick);
		}

		private function handlePoinClick(event : PointClickEvent) : void
		{
			var ball : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('fcBall'));
			view.addChild(ball);
			TweenMax.to(ball, 0.3, {width:30, height:30, y:ball.getEndPoint().y, x:ball.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[ball], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceBall) : void
		{
			if (stateMachineModel.state != "finish")
			{
				var ball : FastClickBall = FastClickBall(point);
				var shape : Shape = ball.getShape();

				shape.x = 0;
				shape.y = 0;
				shape.width = 30;
				shape.height = 30;

				ball.setShape(null);

				var shapeSprite : Sprite = new Sprite();
				shapeSprite.addChild(shape);

				hbox.addChild(shapeSprite);
				view.ballPanel.update();
			}
		}

		private function get view() : FooterView
		{
			return viewComponent as FooterView;
		}
	}
}
