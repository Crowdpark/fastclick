package com.crowdpark.fastclick.mvcs.views.points
{
	import flash.geom.Point;

	import utils.color.randomColor;
	import utils.number.randomIntegerWithinRange;
	import utils.number.randomWithinRange;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends StateMachineMediator
	{
		private var _listOfBalls : Array = new Array();

		override public function onRegister() : void
		{
			super.onRegister();

			for (var i : int = 0; i < 100; i++)
			{
				var pointView : BaseBall = new BaseBall()
					.setEndPoint(new Point(60, contextView.stage.stageHeight - 35))
					.setColor(randomColor())
					.setScore(randomWithinRange(50, 1000));
				pointView.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
				_listOfBalls.push(pointView);
			}

			createRandomPoints();
		}

		private function createRandomPoints() : void
		{
			var fastClickCircle : InterfaceBall = createRandomSizedPoint();
			view.addChild((fastClickCircle as DisplayObject));

			TweenMax.from(fastClickCircle, Math.random() / 10, {onComplete:checkState});
		}

		private function createRandomSizedPoint() : InterfaceBall
		{
			return _listOfBalls[randomIntegerWithinRange(0, _listOfBalls.length - 1)];
		}

		private function checkState() : void
		{
			if (stateMachineModel.state != "finish")
			{
				createRandomPoints();
			}
		}

		private function handleCircleClickEvent(e : MouseEvent) : void
		{
			var fcCircle : InterfaceBall = InterfaceBall(e.currentTarget);
			fcCircle.removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);

			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK, fcCircle));

			TweenMax.to(fcCircle, 0.3, {width:30, height:30, y:fcCircle.getEndPoint().y, x:fcCircle.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[fcCircle], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceBall) : void
		{
			if (stateMachineModel.state != "finish")
			{
				dispatch(new PointClickEvent(PointClickEvent.POINT_TWEEN, point));
			}
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
