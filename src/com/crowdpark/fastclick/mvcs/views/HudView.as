package com.crowdpark.fastclick.mvcs.views
{
	import flash.events.Event;
	import com.crowdpark.fastclick.mvcs.events.FinishGameEvent;
	import org.osmf.events.TimeEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextField;

	import utils.textField.createField;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class HudView extends Sprite
	{
		public var scoreTitle : TextField;
		public var score : TextField;

		public var timeTitle : TextField;
		public var time : TextField;
		
		public var timer:Timer = new Timer(500,0);
		public function HudView()
		{
			init();
		}

		private function init() : void
		{
			createScoreView();
			createTimeView();
		}

		private function createTimeView() : void
		{
			timeTitle = createField("Time:", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(timeTitle);

			time = createField(String(10-timer.currentCount), 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(time);
			
			
			timer.addEventListener(TimerEvent.TIMER, timeCount);
			timer.start();
		}

		private function timeCount(event:TimerEvent):void
		{
			time.text = String(10-timer.currentCount);
			if(time.text == "0")
			{
				dispatchEvent(new Event("finish"));
			}
		}
		private function createScoreView() : void
		{
			scoreTitle = createField("Score:", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(scoreTitle);

			score = createField("0", 0, 0, 200, 20, false, "Verdana", 15, 0);
			addChild(score);
		}
	}
}
