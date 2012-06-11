package com.crowdpark.fastclick.mvcs.commands
{
	import flash.display.Sprite;
	import com.crowdpark.fastclick.mvcs.views.countrdown.CountDownView;
	import org.robotlegs.mvcs.Command;


	/**
	 * @author fatmatekin
	 */
	public class CountDownCommand extends Command
	{
		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);
			mainSprite.addChild(new CountDownView());
			
		}
	}
}
