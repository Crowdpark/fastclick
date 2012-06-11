package com.crowdpark.fastclick.mvcs.commands
{
	import flash.display.Sprite;
	import com.crowdpark.fastclick.mvcs.models.PlayerModel;
	import com.crowdpark.fastclick.mvcs.views.start.StartView;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fatmatekin
	 */
	public class RetryGameCommand extends Command
	{
		[Inject]
		public var playerModel : PlayerModel;

		override public function execute() : void
		{
			var mainSprite : Sprite = Sprite(contextView.getChildByName('mainSprite'));
			mainSprite.removeChildAt(0);
			
			
			var startView : StartView = new StartView();
			startView.init();

			mainSprite.addChild(startView);
		}
	}
}
