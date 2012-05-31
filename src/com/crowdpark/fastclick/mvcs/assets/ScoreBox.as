package com.crowdpark.fastclick.mvcs.assets
{
	import flash.text.TextField;

	import utils.textField.createField;

	import flash.events.Event;

	import utils.draw.createRectangleShape;

	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseBall;

	/**
	 * @author fatmatekin
	 */
	public class ScoreBox extends  BaseBall
	{
		private var _rawShape : Shape;

		public function ScoreBox()
		{
		}

		override public function onAddedToStage(event : Event) : void
		{
			super.onAddedToStage(event);

			addChild(createScoreField(String(getScore())));
		}

		override public function getShape() : Shape
		{
			if (!_rawShape)
			{
				_rawShape = createRectangleShape(createScoreField(String(getScore())).textWidth + 10, 20, getColor());
			}
			return _rawShape;
		}

		private function createScoreField(str : String) : TextField
		{
			return createField(str, 0, 0, 200, 20, true, "Verdana", 17, 0xffffff);
		}
	}
}
