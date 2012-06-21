package com.crowdpark.fastclick.mvcs.views.start
{
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
		public var gameTitleSprite : Sprite = new Sprite();
		public var startButtonSprite : Sprite = new Sprite();
		public var playerNameSprite : Sprite = new Sprite();
		private var playerNameField : TextField;
		private var tfm : TextFormat;
		private var title : TextField;
		private var loadingTextField : TextField;

		override public function onAddedToStageListener(e : Event) : void
		{
			gameTitleSprite.x = (stage.stageWidth - gameTitleSprite.width) / 2;
			gameTitleSprite.y = 60;

			title.x = (stage.stageWidth - title.width) / 2;
			title.y = gameTitleSprite.y + gameTitleSprite.height + 70;

			playerNameField.x = (stage.stageWidth - playerNameField.width) / 2;
			playerNameField.y = title.y + title.height + 20;

			loadingTextField.x = (stage.stageWidth - loadingTextField.width) / 2;
			loadingTextField.y = playerNameField.y + playerNameField.height + 120;

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
			dispatchEvent(new Event(StartView.PLAY_GAME));
		}
	}
}
