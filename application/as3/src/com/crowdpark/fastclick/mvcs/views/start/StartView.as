package com.crowdpark.fastclick.mvcs.views.start
{
	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.views.levels.LevelsView;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author fatmatekin
	 */
	public class StartView extends BaseView
	{
		public var gameTitleSprite : Sprite = new Sprite();
		public var startButtonSprite : Sprite = new Sprite();
		public var playerNameSprite : Sprite = new Sprite();
		private var playerNameField : TextField;
		public var levelsView : LevelsView;
		private var tfm : TextFormat;
		private var title : TextField;
		private var loadingTextField : TextField;
		public static const START_GAME : String = "START_GAME";

		override public function onAddedToStageListener(e : Event) : void
		{
			gameTitleSprite.x = (stage.stageWidth - gameTitleSprite.width) / 2;
			gameTitleSprite.y = 10;

			title.x = (stage.stageWidth - title.width) / 2;
			title.y = gameTitleSprite.y + gameTitleSprite.height + 30;

			playerNameField.x = (stage.stageWidth - playerNameField.width) / 2;
			playerNameField.y = title.y + title.height + 30;

			levelsView.x = (stage.stageWidth - levelsView.width) / 2;
			levelsView.y = playerNameField.y + playerNameField.height + 50;

			loadingTextField.x = (stage.stageWidth - loadingTextField.width) / 2;
			loadingTextField.y = levelsView.y + levelsView.height + 200;
		}

		override public function init() : void
		{
			tfm = new TextFormat("Arial", 20, 0xffffff, true);

			loadingTextField = createField('LOADING...', 0, 0, 0200, 20, false, 'Verdana', 15);

			levelsView = new LevelsView();
			levelsView.init();

			addChild(gameTitleSprite);
			addChild(playerNameSprite);
			addChild(levelsView);
			addChild(loadingTextField);

			createGameTitle();
			createStartButton();
			createPlayerNameField();
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

			title = createField("Welcome", 0, 0, 200, 20, false, "Verdana", 15, 0);
			playerNameField = createField("", 0, title.height + 5, 200, 20, false, "Verdana", 20, 0);

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
			removeChild(loadingTextField);
		}
	}
}
