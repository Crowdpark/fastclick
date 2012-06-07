package com.crowdpark.fastclick.mvcs.views.start
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.display.Shape;

	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author fatmatekin
	 */
	public class StartView extends BaseView
	{
		public var gameTitleSprite : Sprite = new Sprite();
		public var startButtonSprite : Sprite = new Sprite();
		public var playerNameSprite : Sprite = new Sprite();
		private var _playerNameField : TextField;
		private var tfm : TextFormat;
		public static const START_GAME : String = "START_GAME";

		override public function onAddedToStageListener(e : Event) : void
		{
			gameTitleSprite.x = (stage.stageWidth - gameTitleSprite.width) / 2;
			gameTitleSprite.y = 30;

			playerNameSprite.x = (stage.stageWidth - playerNameSprite.width) / 2;
			playerNameSprite.y = gameTitleSprite.y + gameTitleSprite.height + 60;

			startButtonSprite.y = 230;
			startButtonSprite.x = (stage.stageWidth - startButtonSprite.width) / 2;
			startButtonSprite.buttonMode = true;

			startButtonSprite.addEventListener(MouseEvent.CLICK, handleStartClickEvent);
		}

		override public function init() : void
		{
			tfm = new TextFormat("Arial", 20, 0xffffff, true);

			addChild(gameTitleSprite);
			addChild(startButtonSprite);
			addChild(playerNameSprite);

			createGameTitle();
			createStartButton();
			createPlayerNameField();
			
			//updatePlayerNameField();
		}

		private function handleStartClickEvent(e : MouseEvent) : void
		{
			var playerName : String = _playerNameField.text;
			this.getDataProvider().setValueByKey('playerName', playerName);

			dispatchEvent(new Event(StartView.START_GAME));
		}

		private function createGameTitle() : void
		{
			var titleBackground : Shape = createRectangleShape(200, 30, 0x00e0e6);
			var title : TextField = createField('FAST CLICK!', 0, 0, 200, 20, false, 'Verdana', 20, 0xffffff);
			title.x = (titleBackground.width - title.width) / 2;

			gameTitleSprite.addChild(titleBackground);
			gameTitleSprite.addChild(title);
		}

		private function createStartButton() : void
		{
			var startButtonBackground : Shape = createRectangleShape(100, 30, 0x00e0e6);

			var startButtonTitle : TextField = createField('PLAY!', 0, 0, 200, 20, false, 'Verdana', 20, 0xffffff);
			startButtonTitle.x = (startButtonBackground.width - startButtonTitle.width) / 2;

			startButtonSprite.mouseChildren = false;

			startButtonSprite.addChild(startButtonBackground);
			startButtonSprite.addChild(startButtonTitle);
		}

		private function createPlayerNameField() : void
		{
			var tf : TextFormat = new TextFormat();
			tf.font = "Verdana";
			tf.size = 20;
			tf.align = "center";

			_playerNameField = new TextField();
			_playerNameField.type = TextFieldType.INPUT;
			_playerNameField.y = 40;
			_playerNameField.width = 130;
			_playerNameField.height = 30;
			_playerNameField.text = "";
			_playerNameField.border = true;
			_playerNameField.defaultTextFormat = tf;

			var title : TextField = createField("Enter your name", 0, 0, 200, 20, false, "Verdana", 15, 0);

			playerNameSprite.addChild(title);
			playerNameSprite.addChild(_playerNameField);
		}

		public function updatePlayerNameField() : StartView
		{
			var playerName : String = String(this.getDataProvider().getValueByKey('playerName'));
			this.getPlayerNameField().text = playerName;

			return this;
		}

		public function getPlayerNameField() : TextField
		{
			return _playerNameField;
		}

		public function setPlayerNameField(playerNameField : TextField) : StartView
		{
			_playerNameField = playerNameField;
			return this;
		}
	}
}
