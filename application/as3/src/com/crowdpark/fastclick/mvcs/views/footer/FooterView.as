package com.crowdpark.fastclick.mvcs.views.footer
{
	import com.bit101.components.HBox;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.bit101.components.ScrollPane;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FooterView extends BaseView
	{
		public var ballPanel : ScrollPane = new ScrollPane();
		private var hbox : HBox = new HBox();

		override public function init() : void
		{
			super.init();

			addBallPane();
			ballPanel.addChild(hbox);
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			super.onAddedToStageListener(e);

			hbox.x = 30;
			hbox.y = 30;
			hbox.spacing = 20;

			ballPanel.move(0, stage.stageHeight - 60);
			ballPanel.setSize(stage.stageWidth, 60);
		}

		public function addBallPane() : void
		{
			trace('onfooter');

			ballPanel.color = 0xffffff;
			ballPanel.shadow = false;
			ballPanel.showGrid = false;
			ballPanel.autoHideScrollBar = true;
			addChild(ballPanel);
		}

		public function addBallToHbox(ballShape : Sprite) : void
		{
			hbox.addChild(ballShape);
			ballPanel.update();
		}
	}
}
