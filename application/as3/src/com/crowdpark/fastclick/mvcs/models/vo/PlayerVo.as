package com.crowdpark.fastclick.mvcs.models.vo
{
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

		public function getPictureUrl() : String
		{
			return String(this.getValueByKey('pictureUrl'));
		}

		public function setPictureUrl(url : String) : PlayerVo
		{
			this.setValueByKey('pictureUrl', url);
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
			this.setValueByKey('fullName', fullName);
			return this;
		}

		public function getPlayerFullName() : String
		{
			return String(this.getValueByKey('fullName'));
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

		public function setPlayerPicture(content : DisplayObject) : PlayerVo
		{
			this.setValueByKey('playerPicture', content);
			return this;
		}

		public function getPlayerPicture() : DisplayObject
		{
			return DisplayObject(this.getValueByKey('playerPicture'));
			
		}
	}
}
