package com.crowdpark.fastclick.mvcs.views
{
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.core.StateMachineEvents;
	import com.crowdpark.fastclick.mvcs.core.StateMachineMediator;
	import flash.events.MouseEvent;

	/**
	 * @author fatmatekin
	 */
	public class StartViewMediator extends StateMachineMediator
	{
		
		override public function onRegister():void{
			
			super.onRegister();
			view.gameTitleSprite.x = (contextView.stage.stageWidth-view.gameTitleSprite.width)/2;			
			
			view.startButtonSprite.y = 200; 
			view.startButtonSprite.x = (contextView.stage.stageWidth-view.startButtonSprite.width)/2;
			view.startButtonSprite.buttonMode = true;
			
			eventMap.mapListener(view.startButtonSprite, "click", handleStartClickEvent);
			
		}
		
		protected function get view(): StartView{
			
			return viewComponent as StartView;
		}
		
		private function handleStartClickEvent(e:MouseEvent):void{
			
			dispatch(new StateMachineEvents(StateMachineEvents.START));
		}

		override protected function handleStart(e : Event) : void
		{
			super.handleStart(e);
		}

	}
}
