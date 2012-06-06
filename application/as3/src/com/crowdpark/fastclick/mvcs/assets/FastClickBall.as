package com.crowdpark.fastclick.mvcs.assets
{
	import flash.events.Event;

	import utils.number.randomIntegerWithinRange;
	import utils.draw.createCircleShape;

	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;

	/**
	 * @author fatmatekin
	 */
	public class FastClickBall extends BaseGraphic
	{
		private var _rawShape : Shape;

		override public function onAddedToStage(event : Event) : void
		{
			super.onAddedToStage(event);

			addChild(getShape());
		}

		public function getShape() : Shape
		{
			if (!_rawShape)
			{
				_rawShape = createCircleShape(randomIntegerWithinRange(10, 40), this.getColor());
			}

			return _rawShape;
		}

		public function setShape(shape : Shape): FastClickBall
		{
			_rawShape = shape;
			return this;
		}
	}
}
