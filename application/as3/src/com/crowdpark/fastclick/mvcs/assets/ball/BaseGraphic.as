package com.crowdpark.fastclick.mvcs.assets.ball
{
	import utils.draw.createCircleShape;
	import utils.number.randomIntegerWithinRange;

	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class BaseGraphic extends Sprite implements InterfaceCircle
	{
		private var _color : uint;
		private var _direction : Point;
		private var _score : uint;
		private var _startPoint : Point;
		private var _rawShape : Shape;

		public function BaseGraphic()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function onAddedToStage(event : Event) : void
		{
			this.x = this.getStartPoint().x;
			this.y = this.getStartPoint().y;
		}

		public function getColor() : uint
		{
			return _color;
		}

		public function setColor(color : uint) : BaseGraphic
		{
			_color = color;
			return this;
		}

		public function getEndPoint() : Point
		{
			return _direction;
		}

		public function setEndPoint(direction : Point) : BaseGraphic
		{
			_direction = direction;
			return this;
		}

		public function getScore() : uint
		{
			return _score;
		}

		public function setScore(score : uint) : BaseGraphic
		{
			_score = score;
			return this;
		}

		public function getStartPoint() : Point
		{
			return _startPoint;
		}

		public function getShape() : Shape
		{
			if (!_rawShape)
			{
				_rawShape = createCircleShape(randomIntegerWithinRange(10, 40), this.getColor());
			}

			return _rawShape;
		}

		public function setShape(shape : Shape) : BaseGraphic
		{
			_rawShape = shape;
			return this;
		}

		public function setStartPoint(startPoint : Point) : BaseGraphic
		{
			_startPoint = startPoint;
			this.x = _startPoint.x;
			this.y = _startPoint.y;

			return this;
		}
	}
}
