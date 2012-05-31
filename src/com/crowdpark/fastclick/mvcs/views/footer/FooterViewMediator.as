package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.bit101.components.HBox;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.Shape;
	import flash.display.Sprite;

	import utils.draw.createRectangleShape;

	/**
	 * @author fatmatekin
	 */
	public class FooterViewMediator extends StateMachineMediator
	{
		private var hbox : HBox = new HBox();

		override public function onRegister() : void
		{
			super.onRegister();
			var footerBackground : Shape = createRectangleShape(contextView.stage.stageWidth, 60, 0xb3b3b3);
			footerBackground.y = contextView.stage.stageHeight - 60;
			view.addChild(footerBackground);
			view.addChild(hbox);

			addContextListener(PointClickEvent.POINT_CLICK, handlePoinClick);
		}

		private function handlePoinClick(event : PointClickEvent) : void
		{
			var ball : BaseBall = BaseBall(event.getDataprovider().getValueByKey('fcBall'));
			view.addChild(ball);
			TweenMax.to(ball, 0.3, {width:30, height:30, y:ball.getEndPoint().y, x:ball.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[ball], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceBall) : void
		{
			if (stateMachineModel.state != "finish")
			{
				var ball : BaseBall = BaseBall(point);
				var shape : Shape = ball.getShape();
				ball.setShape(null);

				shape.x = ball.x;
				shape.y = ball.y;
				shape.width = 30;
				shape.height = 30;

				var shapeSprite : Sprite = new Sprite();
				shapeSprite.addChild(shape);

				hbox.addChild(shapeSprite);
			}
		}

		private function get view() : FooterView
		{
			return viewComponent as FooterView;
		}
	}
}
