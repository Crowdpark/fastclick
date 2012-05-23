package com.crowdpark.fastclick.mvcs.views
{
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class PointsViewMediator extends Mediator
	{
		override public function onRegister():void{
		
			view.addEventListener("pointClicked", handleCircleClickEvent);
			
		}

		private function handleCircleClickEvent(event : Event) : void
		{
			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK));	
		}
		public function get view(): PointsView
		{
			return viewComponent as PointsView;
		}
		
		
	}
}
