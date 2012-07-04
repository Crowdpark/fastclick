package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.greensock.easing.Linear;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.greensock.TweenMax;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.bit101.components.HBox;
	import com.bit101.components.ScrollPane;
	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class FooterView extends BaseView
	{
		public var ballPanel : ScrollPane = new ScrollPane();
		private var hbox : HBox = new HBox();

		override public function init() : void
		{
			addBallPane();
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			ballPanel.setSize(stage.stageWidth, 60);
			hbox.x = 30;
			hbox.y = 30;
			hbox.spacing = 20;

			ballPanel.y = stage.stageHeight - 210;
		}

		public function addBallPane() : void
		{
			ballPanel.color = 0xffffff;
			ballPanel.shadow = false;
			ballPanel.showGrid = false;
			ballPanel.autoHideScrollBar = true;

			ballPanel.addChild(hbox);
			addChild(ballPanel);
		}

		public function addBallToHbox(ballShape : FastClickBall) : void
		{
			ballShape.x = 30;
			ballShape.y = 30;
			ballShape.setStartPoint(new Point(0, 0));
			ballShape.setEndPoint(new Point(0, 0));

			hbox.addChild(ballShape);
			ballPanel.update();
		}

		public function addClickedCircle(ball : BaseGraphic) : void
		{
			addChild(ball);

			TweenMax.to(ball, 0.3, {width:30, height:30, y:ball.getEndPoint().y, x:ball.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[ball], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceCircle) : void
		{
			var ball : FastClickBall = FastClickBall(point);
			ball.width = 30;
			ball.height = 30;
			addBallToHbox(ball);
		}
	}
}
