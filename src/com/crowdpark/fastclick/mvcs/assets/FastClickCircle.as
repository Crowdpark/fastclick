package com.crowdpark.fastclick.mvcs.assets
{
	import flash.geom.Point;

	import utils.number.randomIntegerWithinRange;
	import utils.geom.randomPoint;
	import utils.draw.createCircleShape;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FastClickCircle extends Sprite
	{
		private var _circle : Sprite;
		private var _circleColor : uint;
		private var _colorArray : Array = new Array(0xff0000, 0x00FF00, 0x0000ff, 0xffff00);
		private var _point : Point;

		public function FastClickCircle()
		{
			this.circle = _circle;
			this.circleColor = _circleColor;
		}

		public function drawCircle(radius : uint) : void
		{
			var circleSprite : Sprite = new Sprite();
			circleSprite.addChild(createCircleShape(radius, this.circleColor));

			circleSprite.x = randomPoint(0, 400, 50, 400).x;
			circleSprite.y = randomPoint(0, 400, 50, 400).y;

			this.circle = circleSprite;
			addChild(this.circle);
		}

		public function get circle() : Sprite
		{
			return _circle;
		}

		public function set circle(circle : Sprite) : void
		{
			this._circle = circle;
		}

		public function setRandomColor() : void
		{
			var randomColor : uint = colorArray[randomIntegerWithinRange(0, 3)];
			this.circleColor = randomColor;
		}

		public function get circleColor() : uint
		{
			return _circleColor;
		}

		public function set circleColor(circleColor : uint) : void
		{
			this._circleColor = circleColor;
		}

		public function get colorArray() : Array
		{
			return _colorArray;
		}

		public function set colorArray(colorArray : Array) : void
		{
			this._colorArray = colorArray;
		}

		public function setDirection() : void
		{
			if (this.colorArray.indexOf(this.circleColor) == 0)
			{
				this.point = new Point(this.circle.x, 0);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 1)
			{
				this.point = new Point(0, this.circle.y);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 2)
			{
				this.point = new Point(550, this.circle.y);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 3)
			{
				this.point = new Point(this.circle.x, 400);
			}
		}

		public function get point() : Point
		{
			return _point;
		}

		public function set point(point : Point) : void
		{
			this._point = point;
		}
	}
}
