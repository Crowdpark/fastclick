package com.crowdpark.fastclick.mvcs.assets
{
	import flash.display.Bitmap;
	import flash.display.Shape;

	import utils.draw.createRectangleShape;

	import flash.events.Event;

	import utils.textField.createField;

	import flash.text.TextField;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class PlayerCanvas extends Sprite
	{
		private var _picture : DisplayObject;
		private var _nameField : TextField;
		private var _levelField : TextField;
		private var _pointsField : TextField;
		private var _leaderboardPlace : TextField;
		private var _backgroundShape : Shape;
		

		public function PlayerCanvas()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageListener);
		}

		private function onAddedToStageListener(event : Event) : void
		{
			addChild(this.getBackgroundShape());
			
			var picture:DisplayObject = this.getPicture();
			picture.width = this.getBackgroundShape().width;
			picture.height = 60;
			
			addChild(picture);
			addChild(this.getLeaderboardPlace());
			addChild(this.getNameField());
			addChild(this.getLevelField());
			addChild(this.getPointsField());

			this.getNameField().y = this.getPicture().y + this.getPicture().height+2;
			this.getLevelField().y = this.getNameField().y + this.getNameField().height + 2;
			this.getPointsField().y = this.getLevelField().y + this.getLevelField().height + 2;
		}

		public function getPicture() : DisplayObject
		{
			if (!_picture)
			{
				_picture = new Sprite();
			}
			return _picture;
		}

		public function setPicture(picture : Bitmap) : PlayerCanvas
		{
			var pictureSprite : Sprite = new Sprite();
			pictureSprite.addChild(DisplayObject(picture));
			
			_picture = pictureSprite;
			return this;
		}

		public function getNameField() : TextField
		{
			if (!_nameField)
			{
				_nameField = createField("", 0, 0, this.getBackgroundShape().width, 20, true, "Verdana", 9, 0xffffff);
				_nameField.wordWrap = true;
			}
			return _nameField;
		}

		public function setNameField(nameString : String) : PlayerCanvas
		{
			this.getNameField().text = nameString;
			return this;
		}

		public function getLevelField() : TextField
		{
			if (!_levelField)
			{
				_levelField = createField("", 0, 0, this.getBackgroundShape().width, 20, true, "Verdana", 9, 0xffffff);
				_levelField.wordWrap = true;
			}

			return _levelField;
		}

		public function setLevelField(levelString : String) : PlayerCanvas
		{
			this.getLevelField().text = levelString;
			return this;
		}

		public function getPointsField() : TextField
		{
			if (!_pointsField)
			{
				_pointsField = createField("", 0, 0, this.getBackgroundShape().width, 20, true, "Verdana", 9, 0xffffff);
				_pointsField.wordWrap = true;
			}
			return _pointsField;
		}

		public function setPointsField(pointsString : String) : PlayerCanvas
		{
			this.getPointsField().text = pointsString;
			return this;
		}

		public function getLeaderboardPlace() : TextField
		{
			if (!_leaderboardPlace)
			{
				_leaderboardPlace = createField("", 0, 0, 200, 20, false, "Verdana", 8, 0xffffff);
			}
			return _leaderboardPlace;
		}

		public function setLeaderboardPlace(leaderboardPlaceString : String) : PlayerCanvas
		{
			this.getLeaderboardPlace().text= leaderboardPlaceString;
			return this;
		}

		public function getBackgroundShape() : Shape
		{
			if (!_backgroundShape)
			{
				_backgroundShape = createRectangleShape(60, 125, 0x000000);
			}
			return _backgroundShape;
		}

		public function setBackgroundShape(backgroundShape : Shape) : void
		{
			_backgroundShape = backgroundShape;
		}
	}
}
