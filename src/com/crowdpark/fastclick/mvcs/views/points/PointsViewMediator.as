package com.crowdpark.fastclick.mvcs.views.points
{
	import utils.geom.randomPoint;
	import utils.display.addChild;

	import com.crowdpark.fastclick.mvcs.models.vo.BallVo;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;
	import com.crowdpark.fastclick.mvcs.assets.ScoreBox;

	import flash.geom.Point;

	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.greensock.TweenMax;

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
			var pointArray : Array = configModel.getBallArray();
			for (var i : int = 0; i < pointArray.length; i++)
			{
				var ballVo : BallVo = pointArray[i];

				var ball : BaseBall = new BaseBall();
				ball.setEndPoint(Point(ballVo.getEndPoint().value));
				ball.setColor(uint(ballVo.getColor().value));
				ball.setScore(uint(ballVo.getScore().value));

				ball.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
				_listOfBalls.push(ball);
			}

			createRandomPoints();
		}

		private function createRandomPoints() : void
		{
			var fastClickCircle : BaseBall = BaseBall(createRandomSizedPoint());
			fastClickCircle.setStartPoint(randomPoint(0, 400, 50, 400));
			addChild(fastClickCircle, view);

			TweenMax.from(fastClickCircle, Math.random() / 2, {onComplete:checkState});
		}

		private function createRandomSizedPoint() : BaseBall
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

			var scoreBox : ScoreBox = ScoreBox(new ScoreBox().setColor(fcCircle.getColor())
				.setStartPoint(fcCircle.getStartPoint())
				.setEndPoint(new Point(70, 5))
				.setScore(fcCircle.getScore()));

			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK, fcCircle, scoreBox));
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
