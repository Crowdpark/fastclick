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
		private var _gifBox : Sprite;
		private var _friendId : String;
		private var _height : uint;

		public function PlayerCanvas()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageListener);
		}

		private function onAddedToStageListener(event : Event) : void
		{
			addChild(this.getBackgroundShape());

			var picture : DisplayObject = this.getPicture();
			picture.width = this.getBackgroundShape().width;
			picture.height = 80;

			addChild(picture);
			addChild(this.getLeaderboardPlace());
			addChild(this.getNameField());
			addChild(this.getLevelField());
			addChild(this.getPointsField());
			addChild(this.getGiftBox());

			this.getNameField().y = picture.y + picture.height + 2;
			this.getLevelField().y = this.getNameField().y + this.getNameField().height + 2;
			this.getPointsField().y = this.getLevelField().y + this.getLevelField().height + 2;
			this.getGiftBox().x = picture.width - this.getGiftBox().width;
		}

		public function getGiftBox() : DisplayObject
		{
			if (!_gifBox)
			{
				var title : TextField = createField('GIFT', 0, 0, 200, 20, false, 'Verdana', 12, 0xffffff);
				title.background = true;
				title.backgroundColor = 0xff0000;

				_gifBox = new Sprite();
				_gifBox.addChild(title);
				_gifBox.mouseChildren = false;
				_gifBox.buttonMode = true;
			}
			return _gifBox;
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
			this.getLevelField().text = 'Level ' + levelString;
			return this;
		}

		public function getPointsField() : TextField
		{
			if (!_pointsField)
			{
				_pointsField = createField("", 0, 0, this.getBackgroundShape().width, 20, true, "Verdana", 9, 0xffffff, 'left');
				_pointsField.wordWrap = true;
			}
			return _pointsField;
		}

		public function setPointsField(pointsString : String) : PlayerCanvas
		{
			this.getPointsField().text = 'score ' + pointsString;
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
			this.getLeaderboardPlace().text = leaderboardPlaceString;
			return this;
		}

		public function getBackgroundShape() : Shape
		{
			if (!_backgroundShape)
			{
				_backgroundShape = createRectangleShape(80, getHeight() - 5, 0x000000);
			}
			return _backgroundShape;
		}

		public function setBackgroundShape(backgroundShape : Shape) : void
		{
			_backgroundShape = backgroundShape;
		}

		public function setFriendId(friendId : String) : PlayerCanvas
		{
			_friendId = friendId;
			return this;
		}

		public function getFriendId() : String
		{
			return _friendId;
		}

		public function setHeight(paneHeight : uint) : void
		{
			_height = paneHeight;
		}

		public function getHeight() : uint
		{
			return _height;
		}
	}
}
