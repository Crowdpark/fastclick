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
			this.colorArray = _colorArray;
			this.point = _point;
		}

		public function drawCircle(radius : uint) : void
		{
			var circleSprite : Sprite = new Sprite();
			circleSprite.addChild(createCircleShape(radius, this.circleColor));
			
			this.circle = circleSprite;
			addChild(this.circle);
		}

		public function setRandomPoint() :void
		{			
			this.x = randomPoint(0, 400, 50, 400).x;
			this.y = randomPoint(0, 400, 50, 400).y;
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
			if (this.colorArray.indexOf(this.circleColor) == 0) //red
			{
				this.point = new Point(this.x, 0);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 1) //green
			{
				this.point = new Point(0, this.y);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 2) //blue
			{
				this.point = new Point(600, this.y);
			}
			else if (this.colorArray.indexOf(this.circleColor) == 3)//yellow
			{
				this.point = new Point(this.x, 450);
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
