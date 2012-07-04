package com.crowdpark.fastclick.mvcs.views.points
{
	import utils.geom.randomPoint;
	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.assets.ScoreBox;
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.events.FastClickBallEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class PointsView extends BaseView
	{
		public static const POINT_CLICK_EVENT : String = "POINT_CLICK_EVENT";

		public function randomizeCircles() : void
		{
			if (stage)
			{
				var ball : FastClickBall = createFastClickBall();
				addChild(ball);

				TweenMax.from(ball, Math.random() / 2, {onComplete:checkState});
				TweenMax.from(ball, Math.random() * 2, {onComplete:removeOne});
			}
		}

		private function createFastClickBall() : FastClickBall
		{
			var playerFriends : Vector.<PlayerVo> = Vector.<PlayerVo>(getDataProvider().getValueByKey('playerFriends'));

			var ball : FastClickBall = new FastClickBall();
			ball.mouseChildren = false;
			ball.setEndPoint(new Point(30, stage.stageHeight - 190));
			var point : uint = Math.ceil(1000 / ball.getShape().width);

			ball.setScore(point);
			ball.setLifeTime(Math.ceil(ball.getShape().width / 10));
			ball.addEventListener(FastClickBallEvent.REMOVE_CIRCLE, onRemoveCircleListener);
			ball.setStartPoint(randomPoint(ball.getShape().width / 2, stage.stageWidth - ball.getShape().width, 130, stage.stageHeight - 210 - ball.getShape().height));
			ball.setPicture(playerFriends[randomIntegerWithinRange(0, playerFriends.length - 1)].getPlayerPicture());
			ball.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			return ball;
		}

		private function onRemoveCircleListener(event : FastClickBallEvent) : void
		{
			removeChild(DisplayObject(event.currentTarget));
		}

		private function checkState() : void
		{
			randomizeCircles();
		}

		private function removeOne() : void
		{
			if (numChildren > 4)
			{
				removeChildAt(0);
			}
		}

		private function handleCircleClickEvent(e : MouseEvent) : void
		{
			FastClickBall(e.currentTarget).removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);

			var fcCircle : InterfaceCircle = InterfaceCircle(e.currentTarget);

			var scoreBox : ScoreBox = ScoreBox(new ScoreBox().setColor(fcCircle.getColor())
				.setStartPoint(fcCircle.getStartPoint())
				.setEndPoint(new Point(70, 5))
				.setScore(fcCircle.getScore()));

			this.getDataProvider().setValueByKey('fcCircle', fcCircle);
			this.getDataProvider().setValueByKey('scoreBox', scoreBox);
			dispatchEvent(new Event(PointsView.POINT_CLICK_EVENT));
		}
	}
}
