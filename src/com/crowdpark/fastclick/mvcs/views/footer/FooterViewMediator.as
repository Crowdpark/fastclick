package com.crowdpark.fastclick.mvcs.views.footer
{
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
			var footerBackground : Shape = createRectangleShape(contextView.stage.stageWidth, 60);
			footerBackground.y = contextView.stage.stageHeight - 60;
			view.addChild(footerBackground);

			addContextListener(PointClickEvent.POINT_TWEEN, handlePointTween);
			addContextListener(PointClickEvent.POINT_CLICK, handlePoinClick);
		}

		private function handlePoinClick(event : PointClickEvent) : void
		{
			var ball : BaseBall = event.ball as BaseBall;
			ballArray.push(ball);
			updateDisplay();
			view.addChild(ball);
		}

		private function updateDisplay() : FooterView
		{
			
			for(var i:uint=0; i<ballArray.length;i++)
			{
				BaseBall(ballArray[i]).x += BaseBall(ballArray[i]).width+20;
			}
			return view;
		}

		private function handlePointTween(event : PointClickEvent) : void
		{
			(event.ball as BaseBall).width = 30;
			(event.ball as BaseBall).height = 30;
			(event.ball as BaseBall).setStartPoint((event.ball as BaseBall).getEndPoint());
		}

		private function get view() : FooterView
		{
			return viewComponent as FooterView;
		}
	}
}
