package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.bit101.components.ScrollPane;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FooterView extends Sprite
	{
		public var ballPanel : ScrollPane;

		public function addBallPane() : void
		{
			trace('onfooter');
			ballPanel = new ScrollPane();
			ballPanel.setSize(stage.stageWidth, 60);
			ballPanel.color = 0xffffff;
			ballPanel.shadow = false;
			ballPanel.showGrid = false;
			ballPanel.autoHideScrollBar = true;
			addChild(ballPanel);
			
		}
	}
}
