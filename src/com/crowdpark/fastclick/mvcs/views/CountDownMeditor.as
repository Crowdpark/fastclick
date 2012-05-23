package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.events.CountDownFinishEvent;
	import flash.display.Sprite;
	import com.greensock.TweenMax;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class CountDownMeditor extends Mediator
	{
		private var number:Number = 3;
		override public function onRegister() : void
		{
			createCountdownNumbers(number);
		}
		private function createCountdownNumbers(number:Number) : void
		{
			if(number >= 0 )
			{			
				var numberSprite:Sprite = view.createNumber(number);
				numberSprite.x = (contextView.stage.stageWidth-40)/2;
				numberSprite.y = (contextView.stage.stageHeight-40)/2;
					
				view.addChild(numberSprite);
				TweenMax.from(numberSprite, 0.5, {scaleX:0.5, scaleY:0.5, onComplete:continueCount, onCompleteParams:[numberSprite]});	
			}else
			{
				dispatch(new CountDownFinishEvent(CountDownFinishEvent.COUNTDOWN_FINISH));			
			}
		}
		private function continueCount(numberSprite:Sprite):void{
			
			view.removeChild(numberSprite);
			number-=1;
			createCountdownNumbers(number);		
	
		}
		public function get view() : CountDownView
		{
			return viewComponent as CountDownView;
		}
	}
}
