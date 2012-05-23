package com.crowdpark.fastclick.mvcs.views
{
	import com.crowdpark.fastclick.mvcs.events.StartClickEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends Mediator
	{
		
		override public function onRegister():void{
			
			view.gameTitleSprite.x = (contextView.stage.stageWidth-view.gameTitleSprite.width)/2;			
			
			view.startButtonSprite.y = 200; 
			view.startButtonSprite.x = (contextView.stage.stageWidth-view.startButtonSprite.width)/2;
			view.startButtonSprite.buttonMode = true;
			
			view.startButtonSprite.addEventListener(MouseEvent.CLICK, handleStartClickEvent);
			
		}
		protected function get view(): StartView{
			
			return viewComponent as StartView;
		}
		private function handleStartClickEvent(e:MouseEvent):void{
			
			dispatch(new StartClickEvent(StartClickEvent.START_COUNTDOWN));
		}
	}
}
