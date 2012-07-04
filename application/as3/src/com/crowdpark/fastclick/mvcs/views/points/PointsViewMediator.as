package com.crowdpark.fastclick.mvcs.views.points
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			addViewListener(PointsView.POINT_CLICK_EVENT, onPointClickEventHandler);

			var playerFriends : Vector.<PlayerVo> = playerModel.getLoadedFriends();
			view.getDataProvider().setValueByKey('playerFriends', playerFriends);

			view.randomizeCircles();
		}

		private function onPointClickEventHandler(event : Event) : void
		{
			var pointClickEvent : PointClickEvent = new PointClickEvent(PointClickEvent.POINT_CLICK);
			pointClickEvent.getDataprovider().setValueByKey('fcCircle', view.getDataProvider().getValueByKey('fcCircle'));
			pointClickEvent.getDataprovider().setValueByKey('scoreBox', view.getDataProvider().getValueByKey('scoreBox'));

			dispatch(pointClickEvent);
		}

		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
