package com.crowdpark.fastclick.mvcs.assets {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;

	import utils.number.randomIntegerWithinRange;
	import utils.draw.createCircleShape;

	import flash.display.Shape;

	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;

	/**
	 * @author fatmatekin
	 */
	public class FastClickBall extends BaseGraphic {
		private var _rawShape : Shape;
		private var _picture : DisplayObject;
		private var _ownWidth : uint;
		private var _ownHeight : uint;

		override public function onAddedToStage(event : Event) : void {
			super.onAddedToStage(event);

			var backgroundShape : Shape = this.getShape();
			var picture : Sprite = Sprite(this.getMaskedPicture());
			addChild(backgroundShape);
			addChild(picture);
		}

		override public function getShape() : Shape {
			if (!_rawShape) {
				_rawShape = createCircleShape(randomIntegerWithinRange(10, 40), this.getColor());
				this.setOwnWidth(_rawShape.width);
				this.setOwnHeight(_rawShape.height);
			}

			return _rawShape;
		}

		public function setPicture(picture : DisplayObject) : FastClickBall {
			_picture = picture;
			return this;
		}

		public function getPicture() : DisplayObject {
			if (!_picture) {
				_picture = new Sprite();
			}

			return _picture;
		}

		public function getMaskedPicture() : DisplayObject {
			
			if(!_picture)
			{
				_picture = new Sprite();
			}
			var backgroundShape : Shape = this.getShape();
			var pictureMaskedSprite : Sprite = new Sprite();

			var pictureMask : Shape = createCircleShape(this.getShape().width / 2, 0x000000);
			_picture.width = backgroundShape.width;
			_picture.height = backgroundShape.height;
			_picture.x = -_picture.width / 2;
			_picture.y = -_picture.height / 2;

			_picture.mask = pictureMask;

			pictureMaskedSprite.addChild(_picture);
			pictureMaskedSprite.addChild(pictureMask);

			return pictureMaskedSprite;
		}

		public function getDuplicateShape() : DisplayObject {
			var picture : DisplayObject = this.getShape();

			var bitmapData : BitmapData = new BitmapData(picture.width, picture.height);
			bitmapData.draw(picture);

			var duplication : Bitmap = new Bitmap(bitmapData);
			duplication.smoothing = true;

			return duplication;
		}

		public function getDuplicatePicture() : DisplayObject {
			var picture : DisplayObject = this.getPicture();

			var bitmapData : BitmapData = new BitmapData(picture.width, picture.height);

			bitmapData.draw(picture);

			var duplication : Bitmap = new Bitmap(bitmapData);
			duplication.smoothing = true;

			return duplication;
		}

		public function getOwnHeight() : uint {
			return _ownHeight;
		}

		public function setOwnHeight(ownHeight : uint) : FastClickBall {
			this._ownHeight = ownHeight;
			return this;
		}

		public function getOwnWidth() : uint {
			return _ownWidth;
		}

		public function setOwnWidth(ownWidth : uint) : FastClickBall {
			this._ownWidth = ownWidth;
			return this;
		}
	}
}
