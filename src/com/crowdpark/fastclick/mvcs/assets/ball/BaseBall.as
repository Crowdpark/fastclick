package com.crowdpark.fastclick.mvcs.assets.ball
{
	import utils.draw.createCircleShape;
	import utils.geom.randomPoint;
	import utils.number.randomWithinRange;

	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceBall;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author fatmatekin
	 */
	public class BaseBall extends Sprite implements InterfaceBall
	{
		private var _color : uint;
		private var _direction : Point;
		private var _score : uint;
		private var _startPoint : Point;
		private var _rawShape : Shape;
		
		public function BaseBall()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}

		public function onAddedToStage(event : Event) : void
		{
			this.x = this.getStartPoint().x;
			this.y = this.getStartPoint().y;
			
			addChild(getShape());
		}

		public function getShape() : Shape
		{
			if (!_rawShape)
			{
				_rawShape = createCircleShape(randomWithinRange(10, 40), this.getColor());
			}

			return _rawShape;
		}

		public function setShape(shape : Shape) : BaseBall
		{
			_rawShape = shape;
			return this;
		}

		public function getColor() : uint
		{
			return _color;
		}

		public function setColor(color : uint) : BaseBall
		{
			_color = color;
			return this;
		}

		public function getEndPoint() : Point
		{
			return _direction;
		}

		public function setEndPoint(direction : Point) : BaseBall
		{
			_direction = direction;
			return this;
		}

		public function getScore() : uint
		{
			return _score;
		}

		public function setScore(score : uint) : BaseBall
		{
			_score = score;
			return this;
		}

		public function getStartPoint() : Point
		{
			if (!_startPoint)
			{
				_startPoint = randomPoint(0, 400, 50, 400);
			}

			return _startPoint;
		}

		public function setStartPoint(startPoint : Point) : BaseBall
		{
			_startPoint = startPoint;
			this.x = _startPoint.x;
			this.y = _startPoint.y;
			return this;
		}
	}
}
