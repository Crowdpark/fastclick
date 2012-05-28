package com.crowdpark.fastclick.mvcs.views.start
{
	import utils.textField.createField;
	import com.bit101.components.InputText;
	import flash.text.TextFieldAutoSize;
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
		public var playerNameField : InputText;
		private var tfm : TextFormat;

		public function StartView()
		{
			tfm = new TextFormat("Arial", 20, 0xffffff, true);
			init();
		}

		private function init() : void
		{
			gameTitleSprite = new Sprite();
			startButtonSprite = new Sprite();
			playerNameSprite = new Sprite();

			addChild(gameTitleSprite);
			addChild(startButtonSprite);
			addChild(playerNameSprite);

			createGameTitle();
			createStartButton();
			createPlayerNameField();
		}

		private function createGameTitle() : void
		{
			var titleBackground : Sprite = new Sprite();
			titleBackground.graphics.beginFill(0xff);
			titleBackground.graphics.drawRect(0, 0, 300, 50);
			titleBackground.graphics.endFill();

			var title : TextField = new TextField();
			title.defaultTextFormat = tfm;
			title.text = "Fast Cick";
			title.x = (titleBackground.width - title.width) / 2;

			gameTitleSprite.addChild(titleBackground);
			gameTitleSprite.addChild(title);
		}

		private function createStartButton() : void
		{
			var startButtonBackground : Sprite = new Sprite();
			startButtonBackground.graphics.beginFill(0xff);
			startButtonBackground.graphics.drawRect(0, 0, 100, 30);
			startButtonBackground.graphics.endFill();

			var startButtonTitle : TextField = new TextField();
			startButtonTitle.mouseEnabled = false;
			startButtonTitle.defaultTextFormat = tfm;
			startButtonTitle.text = "Start";
			startButtonTitle.autoSize = TextFieldAutoSize.LEFT;
			startButtonTitle.x = (startButtonBackground.width - startButtonTitle.width) / 2;

			startButtonSprite.addChild(startButtonBackground);
			startButtonSprite.addChild(startButtonTitle);
		}

		private function createPlayerNameField() : void
		{			
			playerNameField = new InputText();
			playerNameField.name = "playerName";
			playerNameField.y = 20;
			playerNameField.width = 100;
			playerNameField.height = 30;
			
			var title:TextField = createField("Your Name");
			title.textColor = 0xff0000;
			
			playerNameSprite.addChild(title);
			playerNameSprite.addChild(playerNameField);
		}
	}
}
