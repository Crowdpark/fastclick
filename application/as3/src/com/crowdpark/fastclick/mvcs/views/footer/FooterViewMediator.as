package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;

	/**
	 * @author fatmatekin
	 */
	public class FooterViewMediator extends StateMachineMediator
	{
		override public function onRegister() : void
		{
			super.onRegister();

			addContextListener(PointClickEvent.POINT_CLICK, handlePointClick);
		}

		private function handlePointClick(event : PointClickEvent) : void
		{
			var ball : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('fcCircle'));
			view.addClickedCircle(ball);
		}

		private function get view() : FooterView
		{
			return viewComponent as FooterView;
		}
	}
}
