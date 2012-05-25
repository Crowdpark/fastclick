package com.crowdpark.fastclick.mvcs.views.points
{
	import com.crowdpark.fastclick.mvcs.assets.FastClickCircle;
	import com.greensock.TweenMax;

	import flash.events.MouseEvent;

	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();
			createRandomPoints();
		}

		private function createRandomPoints() : void
		{
			var fastClickCircle : FastClickCircle = view.createRandomSizedPoint();
			fastClickCircle.mouseChildren = false;
			view.addChild(fastClickCircle);

			fastClickCircle.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);

			TweenMax.from(fastClickCircle.circle, Math.random(), {onComplete:checkState});
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
			var fcCircle : FastClickCircle = FastClickCircle(e.target);
			fcCircle.removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK));
						
			TweenMax.to(fcCircle, 0.5, {y:fcCircle.point.y, x:fcCircle.point.x, onComplete:handleTweenComplete, onCompleteParams:[fcCircle]});			
		}

		private function handleTweenComplete(point : FastClickCircle) : void
		{
			if (stateMachineModel.state != "finish")
			{
				view.removeChild(point);
			}
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
