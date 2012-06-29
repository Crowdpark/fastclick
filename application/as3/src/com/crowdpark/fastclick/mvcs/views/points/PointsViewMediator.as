package com.crowdpark.fastclick.mvcs.views.points
{
	import utils.display.addChild;
	import utils.geom.randomPoint;
	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.assets.ScoreBox;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineState;
	import com.crowdpark.fastclick.mvcs.events.FastClickBallEvent;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			randomizeCircles();
		}

		private function randomizeCircles() : void
		{
			var ball : FastClickBall = createFastClickBall();
			addChild(ball, view);

			TweenMax.from(ball, Math.random() / 2, {onComplete:checkState});
			TweenMax.from(ball, Math.random() * 2, {onComplete:removeOne});
		}

		private function createFastClickBall() : FastClickBall
		{
			var playerFriends : Vector.<PlayerVo> = playerModel.getLoadedFriends();

			var ball : FastClickBall = new FastClickBall();
			ball.mouseChildren = false;
			ball.setEndPoint(new Point(30, contextView.stage.stageHeight - 190));
			var point : uint = Math.ceil(1000 / ball.getShape().width);

			ball.setScore(point);
			ball.setLifeTime(Math.ceil(ball.getShape().width / 10));
			ball.addEventListener(FastClickBallEvent.REMOVE_CIRCLE, onRemoveCircleListener);
			ball.setStartPoint(randomPoint(ball.getShape().width / 2, contextView.stage.stageWidth - ball.getShape().width, 130, contextView.stage.stageHeight - 210 - ball.getShape().height));
			ball.setPicture(playerFriends[randomIntegerWithinRange(0, playerFriends.length - 1)].getPlayerPicture());
			ball.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			return ball;
		}

		private function onRemoveCircleListener(event : FastClickBallEvent) : void
		{
			view.removeChild(DisplayObject(event.currentTarget));
		}

		private function checkState() : void
		{
			if (stateMachineModel.state != StateMachineState.FINISH)
			{
				randomizeCircles();
			}
		}

		private function removeOne() : void
		{
			if (view)
			{
				if (view.numChildren > 4)
				{
					view.removeChildAt(0);
				}
			}
		}

		private function handleCircleClickEvent(e : MouseEvent) : void
		{
			e.currentTarget.removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);
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
