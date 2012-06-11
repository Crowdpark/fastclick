package com.crowdpark.fastclick.mvcs.views.points
{
	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.assets.ScoreBox;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
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
			for (var i : int = 0; i < pointArray.length; i++)
			{
				var ballVo : BallVo = pointArray[i];

				var ball : FastClickBall = new FastClickBall();
				ball.mouseChildren = false;
				ball.setEndPoint(new Point(60, contextView.stage.stageHeight - 140));
				ball.setColor(uint(ballVo.getValueByKey('color')));
				ball.setScore(uint(ballVo.getValueByKey('score')));

				ball.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
				_listOfBalls.push(ball);
			}

			createRandomPoints();
		}

		private function createRandomPoints() : void
		{
			var fastClickCircle : BaseGraphic = BaseGraphic(createRandomSizedPoint());
			fastClickCircle.setStartPoint(randomPoint(0, contextView.stage.stageWidth, 60, contextView.stage.stageHeight - 140));

			if (view.getObjectsUnderPoint(fastClickCircle.getStartPoint()).length == 0)
			{
				addChild(fastClickCircle, view);
			}

			TweenMax.from(fastClickCircle, Math.random() / 2, {onComplete:checkState});
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
			var fcCircle : InterfaceBall = InterfaceBall(e.currentTarget);

			var scoreBox : ScoreBox = ScoreBox(new ScoreBox().setColor(fcCircle.getColor())
				.setStartPoint(fcCircle.getStartPoint())
				.setEndPoint(new Point(70, 5))
				.setScore(fcCircle.getScore()));

			var baseVo : InterfaceVO = new BaseVo();
			baseVo.setValueByKey('fcBall', fcCircle);
			baseVo.setValueByKey('scoreBox', scoreBox);

			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK).setDataprovider(baseVo));
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
