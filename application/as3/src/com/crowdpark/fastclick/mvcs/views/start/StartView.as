package com.crowdpark.fastclick.mvcs.views.start
{
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
	public class StartView extends Sprite
	{
		public var gameTitleSprite : Sprite;
		public var startButtonSprite : Sprite;
		public var playerNameSprite : Sprite;
		public var playerNameField : TextField;
		private var tfm : TextFormat;

		public function init() : StartView
		{
			tfm = new TextFormat("Arial", 20, 0xffffff, true);
			gameTitleSprite = new Sprite();
			startButtonSprite = new Sprite();
			playerNameSprite = new Sprite();

			addChild(gameTitleSprite);
			addChild(startButtonSprite);
			addChild(playerNameSprite);

			createGameTitle();
			createStartButton();
			createPlayerNameField();
			
			return this;
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

			playerNameField = new TextField();
			playerNameField.type = TextFieldType.INPUT;
			playerNameField.y = 40;
			playerNameField.width = 130;
			playerNameField.height = 30;
			playerNameField.text = "Enter your name here";
			playerNameField.border = true;
			playerNameField.defaultTextFormat = tf;

			var title : TextField = createField("Enter your name", 0, 0, 200, 20, false, "Verdana", 15, 0);

			playerNameSprite.addChild(title);
			playerNameSprite.addChild(playerNameField);
		}
	}
}
