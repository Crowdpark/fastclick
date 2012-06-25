package com.crowdpark.fastclick.mvcs.views.control
{
	import flash.events.MouseEvent;

	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.display.Shape;

	import utils.draw.createRectangleShape;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	/**
	 * @author fatmatekin
	 */
	public class ControlView extends BaseView
	{
		public static const SEND_GIFTS : String = "SEND_GIFTS";
		public static const INVITE_FRIENDS : String = "INVITE_FRIENDS";
		public static const LOBBY : String = "LOBBY";
		
		
		private var buttonContainer : Sprite = new Sprite();
		private var options : Array = ['Free Gifts', 'Lobby', 'Invite Friends'];

		override public function init() : void
		{
			super.init();
			addChild(buttonContainer);

			createSelectionButtons();
		}

		private function createSelectionButtons() : void
		{
			var xpos : uint = 0;
			for (var i : uint = 0; i < options.length;i++)
			{
				var buttonSprite : Sprite = new Sprite();
				buttonSprite.name = options[i];
				var title : TextField = createField(options[i], 0, 0, 200, 20, false, 'Verdana', 13, 0);
				var button : Shape = createRectangleShape(title.width + 5, title.height + 5, 0xffffff);
				title.x = (button.width - title.width) / 2;
				title.y = (button.height - title.height) / 2;

				buttonSprite.addChild(button);
				buttonSprite.addChild(title);
				buttonSprite.mouseChildren = false;
				buttonSprite.buttonMode = true;
				buttonSprite.addEventListener(MouseEvent.CLICK, handleButtonSelect);

				buttonSprite.x = xpos;
				xpos += buttonSprite.width + 10;
				buttonContainer.addChild(buttonSprite);
			}
		}

		private function handleButtonSelect(event : MouseEvent) : void
		{
			switch(event.currentTarget.name)
			{
				case options[0]:
					dispatchEvent(new Event(ControlView.SEND_GIFTS));
					return;
				case options[1]:
					dispatchEvent(new Event(ControlView.LOBBY));
					return;
				case options[2]:
					dispatchEvent(new Event(ControlView.INVITE_FRIENDS));
					return;
			}
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			var controlViewBackground : Shape = createRectangleShape(stage.stageWidth, 40, 0x000000);
			addChildAt(controlViewBackground, 0);

			buttonContainer.x = 10;
			buttonContainer.y = controlViewBackground.height - buttonContainer.height;
		}
	}
}
