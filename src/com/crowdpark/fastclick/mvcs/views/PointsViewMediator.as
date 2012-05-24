package com.crowdpark.fastclick.mvcs.views
{
	import flash.display.Sprite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
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
		
		private function createRandomPoints():void{
			
			var circle:Sprite = view.createRandomSizedPoint();
			view.addChild(circle);
			circle.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);			
			TweenMax.from(circle,Math.random(),{onComplete:checkState}); 
		}
		
		private function checkState():void{
			
			if(stateMachineModel.state != "finish")
			{
				createRandomPoints();				
			}
		}
	
		private function handleCircleClickEvent(e:MouseEvent) : void
		{
			DisplayObject(e.target).removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			view.removeChild(DisplayObject(e.target));			
			
			dispatch(new PointClickEvent(PointClickEvent.POINT_CLICK));
		}
		
		public function get view() : PointsView
		{
			return viewComponent as PointsView;
		}
	}
}
