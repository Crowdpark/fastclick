package com.crowdpark.fastclick.mvcs.views.friends
{
	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import com.bit101.components.HBox;
	import com.bit101.components.ScrollPane;
	import com.crowdpark.fastclick.mvcs.assets.PlayerCanvas;
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author fatmatekin
	 */
	public class FriendsView extends BaseView
	{
		public static const  INVITE_BUTTON_CLICKED : String = 'INVITE_BUTTON_CLICKED';
		public static const SHOW_GIFTS : String = "SHOW_GIFTS";
		private var friendPane : ScrollPane = new ScrollPane();
		private var hbox : HBox = new HBox();
		private	var inviteSprite : Sprite = new Sprite();
		private var paneHeight : uint = 140;

		override public function init() : void
		{
			super.init();

			addInviteButton();

			friendPane.color = 0xffffff;
			friendPane.shadow = false;
			friendPane.showGrid = false;
			friendPane.autoHideScrollBar = true;

			friendPane.addChild(hbox);

			addChild(friendPane);
		}

		private function addInviteButton() : void
		{
			inviteSprite.mouseChildren = false;
			inviteSprite.buttonMode = true;

			var inviteButton : Shape = createRectangleShape(60, 100, 0x00ffff);
			var inviteText : TextField = createField('INVITE FRIEND AND GET A BONUS', 0, 0, 60, 20, true, 'Verdana', 14, 0x000000);
			inviteText.wordWrap = true;

			inviteSprite.addChild(inviteButton);
			inviteSprite.addChild(inviteText);
			inviteSprite.addEventListener(MouseEvent.CLICK, onInviteClickListener);
		}

		private function onInviteClickListener(event : MouseEvent) : void
		{
			dispatchEvent(new Event(FriendsView.INVITE_BUTTON_CLICKED));
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			friendPane.width = stage.stageWidth;
			friendPane.height = paneHeight;
			hbox.spacing = 10;

			inviteSprite.x = -70;

			this.y = stage.stageHeight - friendPane.height - 10;
		}

		private function onGiftBoxListener(event : MouseEvent) : void
		{
			var friendId : String = PlayerCanvas(event.currentTarget.parent).getFriendId();
			getDataProvider().setValueByKey('friendId', friendId);

			dispatchEvent(new Event(FriendsView.SHOW_GIFTS));
		}

		public function createAppFriends() : void
		{
			while (hbox.numChildren > 0)
			{
				hbox.removeChildAt(0);
			}
			var friends : Vector.<PlayerVo> = Vector.<PlayerVo>(getDataProvider().getValueByKey('appFriends'));
			for (var i : uint = 0;i < friends.length;i++)
			{
				var friend : PlayerVo = friends[i];
				var playerCanvas : PlayerCanvas = new PlayerCanvas();
				if (friend.getPlayerType() == 'player')
				{
					playerCanvas.getGiftBox().visible = false;
				}
				playerCanvas.setHeight(paneHeight);
				playerCanvas.setFriendId(friend.getPlayerId());
				playerCanvas.setPicture(friend.getPlayerPicture());
				playerCanvas.setNameField(friend.getPlayerFullName());
				playerCanvas.setLevelField(String(friend.getCurrentLevel()));
				playerCanvas.setPointsField(String(friend.getHighestScore().getScore()));

				playerCanvas.getGiftBox().addEventListener(MouseEvent.CLICK, onGiftBoxListener);
				hbox.addChild(playerCanvas);
				friendPane.update();
			}
		}
	}
}
