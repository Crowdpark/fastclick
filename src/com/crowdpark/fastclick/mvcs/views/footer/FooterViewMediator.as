package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.greensock.easing.Linear;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;
	import com.bit101.components.HBox;

	import flash.display.Sprite;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;

	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;

	import utils.draw.createRectangleShape;

	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;

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
			var ball : BaseBall = BaseBall(event.ball);
			view.addChild(ball);
			TweenMax.to(ball, 0.3, {width:30, height:30, y:ball.getEndPoint().y, x:ball.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[ball, event.scoreBox], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceBall, scoreBox : InterfaceBall) : void
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
