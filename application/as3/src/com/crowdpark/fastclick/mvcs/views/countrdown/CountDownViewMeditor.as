package com.crowdpark.fastclick.mvcs.views.countrdown
{
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.greensock.TweenMax;
	import flash.display.Sprite;



	/**
	 * @author fatmatekin
	 */
	public class CountDownViewMeditor extends StateMachineMediator
	{
		private var cdNumber : uint = 3;

		override public function onRegister() : void
		{
			super.onRegister();
			createCountdownNumbers();
		}

		private function createCountdownNumbers() : void
		{
			if (cdNumber > 0 )
			{
				var numberSprite : Sprite = view.createNumber(cdNumber);
				numberSprite.x = (contextView.stage.stageWidth - 40) / 2;
				numberSprite.y = (contextView.stage.stageHeight - 40) / 2;

				view.addChild(numberSprite);
				TweenMax.from(numberSprite, 0.5, {scaleX:0.5, scaleY:0.5, onComplete:continueCount, onCompleteParams:[numberSprite]});
			}
			else
			{
				dispatch(new StateMachineEvents(StateMachineEvents.GAME));
			}
		}

		override protected function handleGame(e : StateMachineEvents) : void
		{
			super.handleGame(e);
		}

		private function continueCount(numberSprite : Sprite) : void
		{
			view.removeChild(numberSprite);
			cdNumber -= 1;
			createCountdownNumbers();
		}

		public function get view() : CountDownView
		{
			return viewComponent as CountDownView;
		}
	}
}
