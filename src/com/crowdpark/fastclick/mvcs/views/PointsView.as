package com.crowdpark.fastclick.mvcs.views
{
	import flash.trace.Trace;
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import utils.number.randomIntegerWithinRange;
	import utils.draw.createCircleShape;
	import com.greensock.TweenMax;
	import utils.geom.randomPoint;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class PointsView extends Sprite
	{
		
		public var circle:Sprite;
		public function PointsView()
		{
		
			createRandomPoints();	
		}
		private function createRandomPoints():void{
			
			circle = new Sprite();
			circle.addChild(createCircleShape(15));
			circle.buttonMode = true;
			circle.addEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			
			circle.x =randomPoint(0,400, 50, 400).x;
			circle.y = randomPoint(0,400, 50, 400).y;
			addChild(circle);
			TweenMax.from(circle,0.5,{delay:randomIntegerWithinRange(0,0.1),onComplete:createRandomPoints}); 
		}

		private function handleCircleClickEvent(e:MouseEvent) : void
		{
			DisplayObject(e.target).removeEventListener(MouseEvent.CLICK, handleCircleClickEvent);
			removeChild(DisplayObject(e.target));
			dispatchEvent(new Event("pointClicked"));
		}
	}
}
