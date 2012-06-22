package com.crowdpark.fastclick.mvcs.views.levels
{
	import utils.draw.createRectangleShape;
	import utils.textField.createField;

	import com.bit101.components.HBox;
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import com.crowdpark.fastclick.mvcs.events.GameEvents;
	import com.crowdpark.fastclick.mvcs.models.vo.LevelVo;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author fatmatekin
	 */
	public class LevelsView extends BaseView
	{
		private var hbox : HBox = new HBox();
		private var background : Shape;
		private	var title : TextField;
		private	var levelTf : TextField;

		override public function init() : void
		{
			hbox.spacing = 10;

			addChild(hbox);
			hbox.mouseEnabled = false;
			hbox.mouseChildren = false;
		}

		public function createLevels(currentLevel : uint) : void
		{
			var levelArray : Vector.<LevelVo> = Vector.<LevelVo>(getDataProvider().getValueByKey('levelArray'));

			for (var i : uint = 0; i < levelArray.length;i++)
			{
				var levelSprite : Sprite = createLevelSprite(levelArray[i]);
				levelSprite.name = String(levelArray[i].getLevelIndex());

				if (i <= currentLevel - 1)
				{
					levelSprite.buttonMode = true;
					levelSprite.addEventListener(MouseEvent.CLICK, onLevelClickListener);
				}
				else
				{
					var cross : TextField = createField('X', 0, 0, 200, 20, false, 'Verdana', 20, 0xff0000);
					levelSprite.addChild(cross);
				}

				hbox.addChild(levelSprite);
			}
			hbox.x = (stage.stageWidth - this.width) / 2;
		}

		private function onLevelClickListener(event : MouseEvent) : void
		{
			var levelArray : Vector.<LevelVo> = Vector.<LevelVo>(getDataProvider().getValueByKey('levelArray'));

			var selectedLevel = event.currentTarget.name;

			trace(levelArray[uint(selectedLevel - 1)].getGameDuration() + 'selectedLevelduration');
			var gameEvent : GameEvents = new GameEvents(GameEvents.LEVEL_SELECT);
			gameEvent.getDataprovider().setValueByKey('selectedLevelDuration', levelArray[selectedLevel - 1].getGameDuration());
			gameEvent.getDataprovider().setValueByKey('selectedLevel', selectedLevel);
			dispatchEvent(gameEvent);
		}

		private function createLevelSprite(level : LevelVo) : Sprite
		{
			var levelSprite : Sprite = new Sprite();

			background = createRectangleShape(60, 80, 0x000000);
			title = createField('LEVEL', 0, 0, 200, 20, false, 'Verdana', 15, 0xffffff);
			levelTf = createField(String(level.getLevelIndex()), 0, 0, 200, 20, false, 'Verdana', 20, 0xffffff);

			title.x = (background.width - title.width) / 2;
			title.y = 5;
			levelTf.x = (background.width - levelTf.width) / 2;
			levelTf.y = 25;

			levelSprite.addChild(background);
			levelSprite.addChild(title);
			levelSprite.addChild(levelTf);
			levelSprite.mouseChildren = false;

			return levelSprite;
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			hbox.y = (stage.stageHeight - hbox.height) / 2;
		}

		public function enableSelect() : void
		{
			hbox.mouseEnabled = true;
			hbox.mouseChildren = true;
		}
	}
}
