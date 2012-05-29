package com.crowdpark.fastclick.mvcs.views.footer
{
	import flash.display.DisplayObject;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
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
		private var ballArray : Array = new Array();

		override public function onRegister() : void
		{
			super.onRegister();
			var footerBackground : Shape = createRectangleShape(contextView.stage.stageWidth, 60, 0xb3b3b3);
			footerBackground.y = contextView.stage.stageHeight - 60;
			view.addChild(footerBackground);

			addContextListener(PointClickEvent.POINT_TWEEN, handlePointTween);
			addContextListener(PointClickEvent.POINT_CLICK, handlePoinClick);
		}

		private function handlePoinClick(event : PointClickEvent) : void
		{
			var ball : InterfaceBall = event.ball as InterfaceBall;
			ballArray.push(ball);
			updateDisplay();
			view.addChild(ball as DisplayObject);
		}

		private function updateDisplay() : void
		{
			for (var i : uint = 0; i < ballArray.length;i++)
			{
				DisplayObject(ballArray[i]).x += DisplayObject(ballArray[i]).width + 20;
			}
		}

		private function handlePointTween(event : PointClickEvent) : void
		{
			var ball : BaseBall = BaseBall(event.ball);
			ball.width = 30;
			ball.height = 30;
			ball.setStartPoint(ball.getEndPoint());
		}

		private function get view() : FooterView
		{
			return viewComponent as FooterView;
		}
	}
}
