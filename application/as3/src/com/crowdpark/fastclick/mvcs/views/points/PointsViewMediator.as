package com.crowdpark.fastclick.mvcs.views.points
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.assets.ScoreBox;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.crowdpark.fastclick.mvcs.models.vo.BallVo;
	import com.greensock.TweenMax;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	import utils.display.addChild;
	import utils.geom.randomPoint;
	import utils.number.randomIntegerWithinRange;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends StateMachineMediator
	{
		private var _listOfBalls : Array = new Array();

		override public function onRegister() : void
		{
			super.onRegister();
			var pointArray : Vector.<BallVo> = configModel.getBallArray();
			var playerArray : Vector.<PlayerVo> = playerModel.getPlayerFriends();

			for (var i : int = 0; i < playerArray.length; i++)
			{
				// var ballVo : BallVo = pointArray[i];

				var ball : FastClickBall = new FastClickBall();
				ball.mouseChildren = false;
				ball.setEndPoint(new Point(30, contextView.stage.stageHeight - 160));
				// ball.setColor(ballVo.getColor());
				ball.setScore(10);
				ball.setPicture(playerArray[i].getPlayerPicture());

				ball.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
				_listOfBalls.push(ball);
			}

			createRandomPoints();
		}

		private function createRandomPoints() : void
		{
			var fastClickCircle : FastClickBall = FastClickBall(createRandomSizedPoint());
			fastClickCircle.setStartPoint(randomPoint(0, contextView.stage.stageWidth, 60, contextView.stage.stageHeight - 140));

			addChild(fastClickCircle, view);

			TweenMax.from(fastClickCircle, Math.random(), {onComplete:checkState});
		}

		private function createRandomSizedPoint() : BaseGraphic
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
			var fcCircle : InterfaceCircle = InterfaceCircle(e.currentTarget);

			var scoreBox : ScoreBox = ScoreBox(new ScoreBox().setColor(fcCircle.getColor())
				.setStartPoint(fcCircle.getStartPoint())
				.setEndPoint(new Point(70, 5))
				.setScore(fcCircle.getScore()));

			var pointClickEvent : PointClickEvent = new PointClickEvent(PointClickEvent.POINT_CLICK);
			pointClickEvent.getDataprovider().setValueByKey('fcCircle', fcCircle);
			pointClickEvent.getDataprovider().setValueByKey('scoreBox', scoreBox);

			dispatch(pointClickEvent);
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
