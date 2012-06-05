package com.crowdpark.fastclick.mvcs.assets
{
	import flash.text.TextField;

	import utils.textField.createField;

	import flash.events.Event;

	import utils.draw.createRectangleShape;

	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;

	/**
	 * @author fatmatekin
	 */
	public class ScoreBox extends  BaseGraphic
	{
		private var _rawShape : Shape;

		override public function onAddedToStage(event : Event) : void
		{
			super.onAddedToStage(event);

			addChild(getShape());
			addChild(createScoreField(String(getScore())));
		}

		public function getShape() : Shape
		{
			if (!_rawShape)
			{
				_rawShape = createRectangleShape(createScoreField(String(getScore())).width + 10, 20, getColor());
			}
			return _rawShape;
		}

		private function createScoreField(str : String) : TextField
		{
			return createField(str, 0, 0, 200, 20, true, "Verdana", 17, 0xffffff);
		}

		public function setShape(shape : Shape) : ScoreBox
		{
			_rawShape = shape;
			return this;
		}
	}
}
