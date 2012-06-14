package com.crowdpark.fastclick.mvcs.models.vo
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.display.DisplayObject;

	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;

	/**
	 * @author fatmatekin
	 */
	public class PlayerVo extends BaseVo
	{
		public function getPlayerName() : String
		{
			return String(getValueByKey('playerName'));
		}

		public function setPlayerName(playerName : String) : PlayerVo
		{
			this.setValueByKey('playerName', playerName);
			return this;
		}

		public function setPlayerLastName(lastName : String) : PlayerVo
		{
			this.setValueByKey('playerLastName', lastName);
			return this;
		}

		public function getPlayerLastName() : String
		{
			return String(getValueByKey('playerLastName'));
		}

		public function getCurrentScore() : uint
		{
			return uint(getValueByKey('currentScore'));
		}

		public function setCurrentScore(score : uint) : PlayerVo
		{
			this.setValueByKey('currentScore', score);
			return this;
		}

		public function getClickedBallAmount() : uint
		{
			return uint(getValueByKey('clickedBallAmount'));
		}

		public function setClickedBallAmount(amount : uint) : PlayerVo
		{
			this.setValueByKey('clickedBallAmount', amount);
			return this;
		}

		public function setPlayerId(id : uint) : PlayerVo
		{
			this.setValueByKey('id', id);
			return this;
		}

		public function getPlayerId() : uint
		{
			return uint(this.getValueByKey('id'));
		}

		public function setPlayerFullName(fullName : String) : PlayerVo
		{
			this.setValueByKey('playerFullName', fullName);
			return this;
		}

		public function getPlayerFullName() : String
		{
			return String(this.getValueByKey('playerFullName'));
		}

		public function setPlayerPictureUrl(pictureUrl : String) : PlayerVo
		{
			this.setValueByKey('pictureUrl', pictureUrl);
			return this;
		}

		public function getPlayerPictureUrl() : String
		{
			return String(this.getValueByKey('pictureUrl'));
		}

		public function setPlayerPicture(content : Bitmap) : PlayerVo
		{
			this.setValueByKey('playerPictureBitmap', content);
			return this;
		}

		public function getPlayerPicture() : Bitmap
		{
			var playerPictureBitmap : Bitmap = Bitmap(this.getValueByKey('playerPictureBitmap'));

			var duplication : Bitmap;
			duplication = new Bitmap();
			if (playerPictureBitmap)
			{
				duplication = new Bitmap(playerPictureBitmap.bitmapData);
				duplication.smoothing = true;
			}

			return duplication;
		}

		public function setFriendsList(success : Object) : PlayerVo
		{
			this.setValueByKey('friendsList', success);
			return this;
		}

		public function getFriendsList() : Object
		{
			return this.getValueByKey('friendsList');
		}

		public function getCurrentLevel() : uint
		{
			return uint(this.getValueByKey('currentLevel'));
		}

		public function setCurrentLevel(level : uint) : PlayerVo
		{
			this.setValueByKey('currentLevel', level);
			return this;
		}

		public function setLeaderboardPlace(index : uint) : PlayerVo
		{
			this.setValueByKey('leaderboardPlace', index);
			return this;
		}

		public function getLeaderboardPlace() : uint
		{
			return uint(this.getValueByKey('leaderboardPlace'));
		}

		public function setSelectedLevel(level : uint) : PlayerVo
		{
			this.setValueByKey('selectedLevel',level);
			return this;		
		}
		public function getSelectedLevel() : uint
		{
			return uint(this.getValueByKey('selectedLevel'));

		}
		
	}
}
