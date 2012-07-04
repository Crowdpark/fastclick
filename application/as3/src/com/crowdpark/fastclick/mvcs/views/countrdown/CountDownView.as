package com.crowdpark.fastclick.mvcs.views.countrdown
{
	import com.greensock.TweenMax;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import utils.textField.createField;
	import utils.draw.createCircleShape;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class CountDownView extends BaseView
	{
		public static const START_EVENT : String = "START_EVENT";
		private var cdNumber : uint = 3;

		public function createNumber(number : uint) : Sprite
		{
			var countDownSprite : Sprite = new Sprite();
			countDownSprite.addChild(createCircleShape(40, 0));
			countDownSprite.addChild(createField(String(number), -10, -20, 200, 20, false, "Verdana", 30, 0xffffff, "left"));
			return countDownSprite;
		}

		public function createCountdownNumbers() : void
		{
			if (cdNumber > 0 )
			{
				var numberSprite : Sprite = createNumber(cdNumber);

				addChild(numberSprite);
				TweenMax.from(numberSprite, 0.5, {scaleX:0.5, scaleY:0.5, onComplete:continueCount, onCompleteParams:[numberSprite]});
			}
			else
			{
				dispatchEvent(new Event(CountDownView.START_EVENT));
				cdNumber = 0;
			}
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			this.x = (stage.stageWidth - 40) / 2;
			this.y = (stage.stageHeight - 40) / 2;
		}

		private function continueCount(numberSprite : Sprite) : void
		{
			removeChild(numberSprite);
			cdNumber -= 1;
			createCountdownNumbers();
		}
	}
}
