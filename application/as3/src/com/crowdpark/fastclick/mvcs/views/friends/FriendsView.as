package com.crowdpark.fastclick.mvcs.views.friends
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	import com.bit101.components.HBox;
	import com.bit101.components.ScrollPane;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	/**
	 * @author fatmatekin
	 */
	public class FriendsView extends BaseView
	{
		private var friendPane : ScrollPane = new ScrollPane();
		private var hbox : HBox = new HBox();

		override public function init() : void
		{
			super.init();
			friendPane.color = 0xffffff;
			friendPane.shadow = false;
			friendPane.showGrid = false;
			friendPane.autoHideScrollBar = true;

			friendPane.addChild(hbox);

			addChild(friendPane);
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			
			friendPane.width = stage.stageWidth;
			friendPane.height = 60;
			hbox.spacing = 10;
			
			this.y = stage.stageHeight - friendPane.height-10;
			
		}

		public function createFriend() : void
		{
			var friend : PlayerVo = PlayerVo(this.getDataProvider().getValueByKey('currentFriend'));
			hbox.addChild(friend.getPlayerPicture());
			friendPane.update();
		}
	}
}
