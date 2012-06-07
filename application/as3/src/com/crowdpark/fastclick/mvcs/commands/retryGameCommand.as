package com.crowdpark.fastclick.mvcs.commands
{
	import flash.net.SharedObject;

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
			contextView.removeChildAt(0);

			var startView : StartView = new StartView();
			startView.init();

			var flashCookie : SharedObject = SharedObject(playerModel.getFlashCookie());

			if (flashCookie.data.playername)
			{
				startView.getDataProvider().setValueByKey('playerName', flashCookie.data.playername);
				startView.updatePlayerNameField();
			}

			contextView.addChild(startView);
		}
	}
}
