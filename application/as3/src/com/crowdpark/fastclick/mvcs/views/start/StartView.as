package com.crowdpark.fastclick.mvcs.views.start
{
	import flash.display.DisplayObject;
	import flash.display.Shape;

	import utils.draw.createRectangleShape;

	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;

	import utils.textField.createField;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author fatmatekin
	 */
	public class StartView extends BaseView
	{
		public static const PLAY_GAME : String = "PLAY_GAME";
		public static const START_GAME : String = "START_GAME";
		public static const RECEIVE_GIFT : String = "RECEIVE_GIFT";
		public var gameTitleSprite : Sprite = new Sprite();
		public var startButtonSprite : Sprite = new Sprite();
		public var playerNameSprite : Sprite = new Sprite();
		private var playerNameField : TextField;
		private var tfm : TextFormat;
		private var title : TextField;
		private var loadingTextField : TextField;
		public var giftContainer : Sprite = new Sprite();
		public var giftsBox : Sprite = new Sprite();

		override public function onAddedToStageListener(e : Event) : void
		{
			gameTitleSprite.x = (stage.stageWidth - gameTitleSprite.width) / 2;
			gameTitleSprite.y = 60;

			title.x = (stage.stageWidth - title.width) / 2;
			title.y = gameTitleSprite.y + gameTitleSprite.height + 70;

			playerNameField.x = (stage.stageWidth - playerNameField.width) / 2;
			playerNameField.y = title.y + title.height + 20;

			giftsBox.y = playerNameField.y + playerNameField.height + 90;
			giftContainer.y = giftsBox.y + giftsBox.height + 20;

			loadingTextField.x = (stage.stageWidth - loadingTextField.width) / 2;
			loadingTextField.y = playerNameField.y + playerNameField.height + 180;

			startButtonSprite.x = stage.stageWidth;
			startButtonSprite.y = loadingTextField.y;
		}

		override public function init() : void
		{
			tfm = new TextFormat("Arial", 20, 0xffffff, true);

			loadingTextField = createField('LOADING...', 0, 0, 200, 20, false, 'Verdana', 20);

			addChild(gameTitleSprite);
			addChild(playerNameSprite);
			addChild(loadingTextField);

			createGameTitle();
			createStartButton();
			createPlayerNameField();
		}

		private function createGameTitle() : void
		{
			var title : TextField = createField('FAST CLICK!', 0, 0, 200, 20, false, 'Verdana', 30, 0xffffff);
			title.background = true;
			title.backgroundColor = 0x00e0e6;

			gameTitleSprite.addChild(title);
		}

		private function createStartButton() : void
		{
			var startButtonTitle : TextField = createField('PLAY!', 0, 0, 200, 20, false, 'Verdana', 25, 0xffffff);
			startButtonTitle.background = true;
			startButtonTitle.backgroundColor = 0x00e0e6;
			startButtonSprite.mouseChildren = false;

			startButtonSprite.addChild(startButtonTitle);
		}

		private function createPlayerNameField() : void
		{
			var tf : TextFormat = new TextFormat();
			tf.font = "Verdana";
			tf.size = 20;
			tf.align = "center";

			title = createField("Welcome", 0, 0, 200, 20, false, "Verdana", 15, 0);
			playerNameField = createField("", 0, title.height + 5, 200, 20, false, "Verdana", 25, 0);

			addChild(title);
			addChild(playerNameField);
		}

		public function updatePlayerNameField(name : String, lastName : String) : StartView
		{
			getDataProvider().setValueByKey('playerName', name);
			getDataProvider().setValueByKey('playerLastName', lastName);

			if (name == '' && lastName == '')
			{
				this.getPlayerNameField().text = 'Your Name';
			}
			else
			{
				this.getPlayerNameField().text = name + ' ' + lastName;
			}
			playerNameField.x = (stage.stageWidth - playerNameField.width) / 2;
			return this;
		}

		public function getPlayerNameField() : TextField
		{
			return playerNameField;
		}

		public function setPlayerNameField(playerNameField : TextField) : StartView
		{
			playerNameField = playerNameField;
			return this;
		}

		public function removeLoading() : void
		{
			if (contains(loadingTextField))
			{
				removeChild(loadingTextField);
			}
		}

		public function addStartButton() : void
		{
			addChild(startButtonSprite);
			startButtonSprite.buttonMode = true;
			startButtonSprite.addEventListener(MouseEvent.CLICK, handleStartButtonClick);
			TweenMax.to(startButtonSprite, 0.5, {x:(stage.stageWidth - startButtonSprite.width) / 2});
		}

		public function handleStartButtonClick(event : MouseEvent) : void
		{
			removeChild(startButtonSprite);
			if (contains(giftsBox))
			{
				removeChild(giftsBox);
				removeChild(giftContainer);
			}

			dispatchEvent(new Event(StartView.PLAY_GAME));
		}

		public function showGifts() : void
		{
			var gifts : Vector.<GiftVo> = Vector.<GiftVo>(getDataProvider().getValueByKey('gift'));
			while (giftsBox.numChildren > 0)
			{
				giftsBox.removeChildAt(0);
			}
			if (gifts.length>0)
			{
				addChild(giftsBox);
				addChild(giftContainer);

				var giftView : TextField = createField('COLLECT YOUR GIFTS', 0, 0, 200, 20, false, 'Verdana', 18, 0xffffff);
				giftView.background = true;
				giftView.backgroundColor = 0x00ff00;

				giftsBox.addChild(giftView);
				giftsBox.mouseChildren = false;
				giftsBox.x = (stage.stageWidth - giftsBox.width) / 2;

				giftsBox.addEventListener(MouseEvent.CLICK, onGiftContainerListener);
			}
		}

		private function onGiftContainerListener(event : MouseEvent) : void
		{
			giftsBox.removeEventListener(MouseEvent.CLICK, onGiftContainerListener);
			var gifts : Vector.<GiftVo> = Vector.<GiftVo>(getDataProvider().getValueByKey('gift'));

			var xpos = 0;
			for (var i : uint = 0;i < gifts.length;i++)
			{
				var giftSprite : Sprite = new Sprite();
				giftSprite.name = String(gifts[i].getGiftRequest());
				var giftView : TextField = createField(String(gifts[i].getGiftAmount()), 0, 0, 200, 20, false, 'Verdana', 16, 0xffffff);
				giftView.background = true;
				giftView.backgroundColor = 0x00ff00;

				giftSprite.addChild(giftView);
				giftSprite.x = xpos;
				xpos += giftSprite.width + 10;
				giftSprite.mouseChildren = false;
				giftSprite.addEventListener(MouseEvent.CLICK, onGiftListener);

				giftContainer.addChild(giftSprite);
			}
			giftContainer.x = (stage.stageWidth - giftContainer.width) / 2;
			giftContainer.y = giftsBox.y + giftsBox.height + 20;
		}

		private function onGiftListener(event : MouseEvent) : void
		{
			getDataProvider().setValueByKey('receivedGift', event.currentTarget.name);
			dispatchEvent(new Event(StartView.RECEIVE_GIFT));
			giftContainer.removeChild(DisplayObject(event.currentTarget));
		}
	}
}
